@echo off
setlocal EnableExtensions
chcp 65001 >nul
cd /d "%~dp0"
title Song AI Maker - don24crk

REM Configure APPLIO_DIR / APPLIO_ENV_DIR here if your Ultimate RVC folder differs.
if not defined APPLIO_DIR if exist "C:\Users\User\ultimate-rvc\src\ultimate_rvc\rvc\infer" set "APPLIO_DIR=C:\Users\User\ultimate-rvc\src\ultimate_rvc"
if not defined APPLIO_ENV_DIR if exist "C:\Users\User\ultimate-rvc\.venv\Scripts\python.exe" set "APPLIO_ENV_DIR=C:\Users\User\ultimate-rvc\.venv"

set "PYTHON_EXE="
if defined APPLIO_ENV_DIR if exist "%APPLIO_ENV_DIR%\Scripts\python.exe" set "PYTHON_EXE=%APPLIO_ENV_DIR%\Scripts\python.exe"
if not defined PYTHON_EXE if exist "%~dp0.venv\Scripts\python.exe" set "PYTHON_EXE=%~dp0.venv\Scripts\python.exe"
if not defined PYTHON_EXE if exist "%~dp0env\Scripts\python.exe" set "PYTHON_EXE=%~dp0env\Scripts\python.exe"

if defined PYTHON_EXE (
    echo [INFO] Starting with: %PYTHON_EXE%
    "%PYTHON_EXE%" "%~dp0songai-web.py"
) else (
    echo [INFO] No project Python environment found. Trying Python Launcher...
    where py >nul 2>nul
    if not errorlevel 1 (
        py -3 "%~dp0songai-web.py"
    ) else (
        where python >nul 2>nul
        if errorlevel 1 (
            echo [ERROR] Python was not found. Install Python or set APPLIO_ENV_DIR in this BAT file.
            pause
            exit /b 1
        )
        python "%~dp0songai-web.py"
    )
)
if errorlevel 1 (
    echo.
    echo [ERROR] Song AI Maker stopped with an error. Check the messages above.
    pause
)
endlocal
