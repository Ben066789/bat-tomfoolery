@echo off
setlocal

echo ==========================
echo      FFmpeg Video Cutter
echo ==========================
echo.

where ffmpeg >nul 2>&1

if %errorlevel% neq 0 (
    echo ffmpeg is not installed
    installing now
    winget install -e --id Gyan.FFmpeg
)

set /p input=Enter input video: 
set /p output=Enter output file: 
set /p time=Enter duration: 

echo.
echo Cutting video...
ffmpeg -i "%input%" -t %time% -c copy "%output%"

echo.
if %errorlevel% equ 0 (
    echo Done!
) else (
    echo Failed.
)

pause
