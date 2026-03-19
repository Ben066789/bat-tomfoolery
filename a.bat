@echo off 
echo grabbing flash drive letter... 
echo. 
set "flshlttr=%~d0" 
timeout /t 3 >nul 
echo drive letter is "%flshlttr%"... 
echo. 
echo starting veracrypt... 
timeout /t 3 >nul 
cd /d "%flshlttr%\veracrypt" 
vc /v "%flshlttr%\drives\rgd_flgn" /l Z /a /q 
echo. 
set /p choice="firefox? (y/n): " 
if /i "%choice%"=="y" 
(echo. start "" "Z:\FirefoxPortable\FirefoxPortable.exe") 
else ( echo. echo aight bro timeout /t 3 >nul )