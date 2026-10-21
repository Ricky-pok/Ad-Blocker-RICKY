@echo off
setlocal
title Ad Blocker RICKY - Mullvad DNS Setup

:: Self-elevate to admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"

echo.
echo ===============================================
echo    Ad Blocker RICKY
echo    Automatic installer
echo ===============================================
echo.
echo Downloading script from GitHub...

set "SCRIPT=%TEMP%\Set-MullvadDNS.ps1"
set "URL=https://raw.githubusercontent.com/Ricky-pok/Ad-Blocker-RICKY/main/Set-MullvadDNS.ps1"

powershell -NoProfile -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest -Uri '%URL%' -OutFile '%SCRIPT%' -UseBasicParsing -ErrorAction Stop } catch { exit 1 }"

if not exist "%SCRIPT%" (
    echo.
    echo ERROR: Could not download the script.
    echo Check your internet connection.
    echo.
    pause
    exit /b 1
)

echo Script downloaded. Running...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%"

del /q "%SCRIPT%" 2>nul

endlocal
