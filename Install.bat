@echo off
setlocal
title Ad Blocker RICKY - Mullvad DNS Setup

echo.
echo ===============================================
echo    Ad Blocker RICKY
echo    Instalador automatico
echo ===============================================
echo.
echo Descargando script desde GitHub...

set "SCRIPT=%TEMP%\Set-MullvadDNS.ps1"
set "URL=https://raw.githubusercontent.com/Ricky-pok/Ad-Blocker-RICKY/main/Set-MullvadDNS.ps1"

powershell -NoProfile -Command "try { Invoke-WebRequest -Uri '%URL%' -OutFile '%SCRIPT%' -UseBasicParsing -ErrorAction Stop } catch { exit 1 }"

if not exist "%SCRIPT%" (
    echo.
    echo ERROR: No se pudo descargar el script.
    echo Verifica tu conexion a internet.
    echo.
    pause
    exit /b 1
)

echo Script descargado. Ejecutando...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%"

del /q "%SCRIPT%" 2>nul
endlocal
