@echo off

echo ==========================
echo      FFmpeg Video Cutter
echo ==========================
echo.

set /p input=Enter input video: 
set /p output=Enter output file: 
set /p time=Enter duration: 

echo.
echo cutting video
ffmpeg -i "%input%" -t %time% -c copy "%output%"

echo.
if %errorlevel%==0 (
    echo done
) else (
    echo failed
)

pause