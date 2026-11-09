@echo off
title QR VAULT — 100% Offline Permanent QR Code Studio
echo ===================================================
echo     QR VAULT: PERMANENT & OFFLINE QR CODE STUDIO
echo ===================================================
echo Launching as dedicated desktop application...

set "HTML_PATH=%~dp0index.html"

:: Check for 64-bit Edge
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" --app="file:///%HTML_PATH%" --window-size=1280,850
    exit
)

:: Check for 32-bit Edge
if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" --app="file:///%HTML_PATH%" --window-size=1280,850
    exit
)

:: Check for Chrome App Mode
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" --app="file:///%HTML_PATH%" --window-size=1280,850
    exit
)

:: Fallback: Open Default Browser
start "" "%HTML_PATH%"
exit
