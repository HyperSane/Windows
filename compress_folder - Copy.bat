@echo off
setlocal

REM Update this path with the correct path to your Python executable
set PYTHON_EXECUTABLE=C:\Users\Mortem\AppData\Local\Microsoft\WindowsApps\python.exe

if "%~1"=="" (
    echo No folder specified.
    exit /b 1
)

%PYTHON_EXECUTABLE% "F:\APPS\Python\Projects\Right-Click Compress\compress_folder.py" "%~1"
pause
