@echo off

if "%~1"=="" (
    echo.
    echo available paths:
    echo ----------------
    type "%~dp0paths.txt"
    echo.
    echo Usage: c alias
    exit /b
)

for /f "usebackq tokens=1,* delims==" %%A in ("%~dp0paths.txt") do (
    if /i "%%A"=="%~1" (
        cd /d "%%B"
        exit /b
    )
)

echo Path alias "%~1" not found.
