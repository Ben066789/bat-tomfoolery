@echo off

echo starting veracrypt...
timeout /t 2 >nul

cd /d "C:\Program Files\VeraCrypt"

"C:\Program Files\VeraCrypt\VeraCrypt.exe" /v "%flshlttr%\drives\rgd_flgn" /l Z /a /q

if not exist Z:\ (
    timeout /t 1 >nul
    goto waitloop
)
timeout /t 2 >nul
start Z:
echo.
set /p choice="firefox? (y/n): "

if /i "%choice%"=="y" (
    echo.
    start "" "Z:\FirefoxPortable\FirefoxPortable.exe"
) else (
    echo.
    echo aight bro
    timeout /t 3 >nul
)
