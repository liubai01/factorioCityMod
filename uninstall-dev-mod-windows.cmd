@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
set "PS_SCRIPT=%SCRIPT_DIR%scripts\uninstall-dev-mod.ps1"

if not exist "%PS_SCRIPT%" (
    echo [ERROR] Cannot find script: "%PS_SCRIPT%"
    pause
    exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%PS_SCRIPT%"
set "EXIT_CODE=%ERRORLEVEL%"

if not "%EXIT_CODE%"=="0" (
    echo.
    echo [ERROR] Uninstall failed with exit code %EXIT_CODE%.
    pause
)

exit /b %EXIT_CODE%
