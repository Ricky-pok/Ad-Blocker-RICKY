<#
.SYNOPSIS
  Ad Blocker RICKY - Configura Mullvad DNS por DoH en Windows.

.DESCRIPTION
  Registra los endpoints DoH de Mullvad, aplica el DNS a nivel de adaptador
  en todos los adaptadores fisicos activos (Wi-Fi, Ethernet, USB-C, etc.),
  desactiva smart multi-homed name resolution y limpia el cache DNS.

.PARAMETER List
  Variante del filtro de Mullvad:
    base    -> Solo DNS cifrado, sin bloqueo.
    adblock -> Ads + trackers. [Default]
    family  -> Ads + trackers + malware + adulto.
    all     -> Todo lo anterior + redes sociales + gambling.

.PARAMETER Rollback
  Revierte DNS a DHCP, remueve los endpoints DoH y restaura smart multi-homed.

.EXAMPLE
  .\Set-MullvadDNS.ps1
  .\Set-MullvadDNS.ps1 -List family
  .\Set-MullvadDNS.ps1 -Rollback

.NOTES
  Author:  Ricky (Jose E. Felix Vidal)
  License: MIT
  Repo:    https://github.com/Ricky-pok/Ad-Blocker-RICKY
#>

param(
    [ValidateSet('base','adblock','family','all')]
    [string]$List = 'adblock',
    [switch]$Rollback
)

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $argLine = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" -List $List"
    if ($Rollback) { $argLine += " -Rollback" }
    Start-Process powershell -Verb RunAs -ArgumentList $argLine
    exit
}

$dns = @{
    base    = @{ v4='194.242.2.2'; v6='2a07:e340::2'; host='dns.mullvad.net' }
    adblock = @{ v4='194.242.2.3'; v6='2a07:e340::3'; host='adblock.dns.mullvad.net' }
    family  = @{ v4='194.242.2.6'; v6='2a07:e340::6'; host='family.dns.mullvad.net' }
    all     = @{ v4='194.242.2.9'; v6='2a07:e340::9'; host='all.dns.mullvad.net' }
}

$cfg = $dns[$List]
$template = "https://$($cfg.host)/dns-query"

Write-Host ""
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "   Ad Blocker RICKY   |   Mullvad DNS [$List]" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan

$adapters = Get-NetAdapter -Physical | Where-Object Status -eq 'Up'

if (-not $adapters) {
    Write-Host "`nNo se encontraron adaptadores fisicos activos." -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}

if ($Rollback) {
    Write-Host "`n[Rollback] Revirtiendo configuracion..." -ForegroundColor Yellow
    foreach ($a in $adapters) {
        Set-DnsClientServerAddress -InterfaceIndex $a.ifIndex -ResetServerAddresses
        Write-Host "  Reset: $($a.Name)" -ForegroundColor Gray
    }
    Remove-DnsClientDohServerAddress -ServerAddress $cfg.v4 -ErrorAction SilentlyContinue
    Remove-DnsClientDohServerAddress -ServerAddress $cfg.v6 -ErrorAction SilentlyContinue
    Set-DnsClientGlobalSetting -SmartMultiHomedNameResolution $true
    Clear-DnsClientCache
    Write-Host "`nRollback completo." -ForegroundColor Green
    Read-Host "Presiona Enter para salir"
    exit 0
}

Write-Host "`n[1/4] Registrando endpoints DoH..." -ForegroundColor Cyan
Add-DnsClientDohServerAddress -ServerAddress $cfg.v4 -DohTemplate $template -AllowFallbackToUdp $false -AutoUpgrade $true -ErrorAction SilentlyContinue
Add-DnsClientDohServerAddress -ServerAddress $cfg.v6 -DohTemplate $template -AllowFallbackToUdp $false -AutoUpgrade $true -ErrorAction SilentlyContinue
Write-Host "  IPv4: $($cfg.v4) -> $template" -ForegroundColor Gray
Write-Host "  IPv6: $($cfg.v6) -> $template" -ForegroundColor Gray

Write-Host "`n[2/4] Aplicando DNS a adaptadores fisicos activos..." -ForegroundColor Cyan
foreach ($a in $adapters) {
    Set-DnsClientServerAddress -InterfaceIndex $a.ifIndex -ServerAddresses @($cfg.v4, $cfg.v6)
    Write-Host "  OK  $($a.Name)  [$($a.InterfaceDescription)]" -ForegroundColor Green
}

Write-Host "`n[3/4] Deshabilitando smart multi-homed name resolution..." -ForegroundColor Cyan
Set-DnsClientGlobalSetting -SmartMultiHomedNameResolution $false

Write-Host "`n[4/4] Limpiando cache DNS..." -ForegroundColor Cyan
Clear-DnsClientCache

Write-Host ""
Write-Host "===============================================" -ForegroundColor Green
Write-Host "   Setup completo." -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Green
Write-Host "   Verifica:  https://mullvad.net/en/check" -ForegroundColor Gray
Write-Host "   Test ads:  https://d3ward.github.io/toolz/adblock.html" -ForegroundColor Gray
Write-Host ""
Read-Host "Presiona Enter para salir"
