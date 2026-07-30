@echo off
setlocal

echo ==mp3 to mp4 cli== 
echo.

set /p "IMAGE=enter image file: "

set /p "AUDIO=enter mp3 file: "


set /p "OUTPUT=output filename: "

if "%OUTPUT%"=="" set "OUTPUT=output"

ffmpeg -loop 1 -i "%IMAGE%" -i "%AUDIO%" ^
-c:v libx264 -tune stillimage ^
-c:a aac -b:a 192k ^
-pix_fmt yuv420p ^
-shortest "%OUTPUT%.mp4"

echo.
echo done created "%OUTPUT%.mp4"
pause
