@echo off
setlocal

set TASKNAME=ermm

echo.
set /p SHUTTIME=enter shutdown time: 

schtasks /query /tn "%TASKNAME%" >nul 2>&1

if %errorlevel%==0 (
    echo task found. updating...
) else (
    echo task not found. creating...
)

schtasks /create ^
 /tn "%TASKNAME%" ^
 /tr "shutdown.exe /s /t 10" ^
 /sc daily ^
 /st %SHUTTIME% ^
 /f

if %errorlevel%==0 (
    echo.
    echo time set to %SHUTTIME%.
) else (
    echo.
    echo failed to create/update the task.
)

pause
