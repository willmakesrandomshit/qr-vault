@echo off
title QR VAULT — Instant Wi-Fi & QR Studio
echo Detecting active Wi-Fi connection...

set "WIFI_SSID="
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interfaces 2^>nul ^| findstr /c:" SSID"') do (
    if not defined WIFI_SSID set "WIFI_SSID=%%a"
)

if defined WIFI_SSID (
    for /f "tokens=* delims= " %%b in ("%WIFI_SSID%") do set "WIFI_SSID=%%b"
    echo Auto-detected Wi-Fi: %WIFI_SSID%
)

set "HTML_PATH=%~dp0index.html"
set "QUERY_PARAM="
if defined WIFI_SSID (
    set "QUERY_PARAM=?type=wifi&ssid=%WIFI_SSID%"
)

:: Check for 64-bit Edge
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" --app="file:///%HTML_PATH%%QUERY_PARAM%" --window-size=1100,800
    exit
)

:: Check for 32-bit Edge
if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" --app="file:///%HTML_PATH%%QUERY_PARAM%" --window-size=1100,800
    exit
)

:: Check for Chrome
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" --app="file:///%HTML_PATH%%QUERY_PARAM%" --window-size=1100,800
    exit
)

start "" "%HTML_PATH%%QUERY_PARAM%"
exit
