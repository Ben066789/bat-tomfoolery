@echo off
setlocal

:: image selection
for /f "delims=" %%I in ('powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $o=New-Object System.Windows.Forms.OpenFileDialog; $o.Filter='Image Files|*.jpg;*.jpeg;*.png;*.bmp'; if($o.ShowDialog() -eq 'OK'){$o.FileName}"') do set "IMAGE=%%I"

if not defined IMAGE exit /b

:: mp3 selection
for /f "delims=" %%I in ('powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $o=New-Object System.Windows.Forms.OpenFileDialog; $o.Filter='Audio Files|*.mp3'; if($o.ShowDialog() -eq 'OK'){$o.FileName}"') do set "AUDIO=%%I"

if not defined AUDIO exit /b

set "OUTPUT=output.mp4"

ffmpeg -loop 1 -i "%IMAGE%" -i "%AUDIO%" ^
-c:v libx264 -tune stillimage ^
-c:a aac -b:a 192k ^
-pix_fmt yuv420p ^
-shortest "%OUTPUT%"

echo.
echo Done! Created "%OUTPUT%"
pause
