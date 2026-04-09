@echo off
title Screen Timeout Selector

echo Choose screen timeout:
echo [1] 1 minute
echo [2] 5 minutes
echo [3] 10 minutes
echo [4] 30 minutes
echo [5] Never
set /p choice=Enter choice:

if %choice%==1 set time=60
if %choice%==2 set time=300
if %choice%==3 set time=600
if %choice%==4 set time=1800
if %choice%==5 set time=0

if not defined time (
    echo Invalid choice.
    pause
    exit
)

:: Set timeout for plugged in (AC)
powercfg /change monitor-timeout-ac %time%

:: Set timeout for battery (DC)
powercfg /change monitor-timeout-dc %time%

echo Screen timeout set to %time% seconds.
pause