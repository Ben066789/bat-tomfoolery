@echo off
setlocal

echo === shhhhhhhhhhhhhhhhhhhhhhhhhh ===

set DESKTOP=%USERPROFILE%\Desktop

echo Checking OpenSSH Server...
dism /online /Get-Capabilities | findstr /i "OpenSSH.Server" | findstr /i "Installed" >nul

IF %ERRORLEVEL% NEQ 0 (
    echo Installing OpenSSH Server...
    dism /online /Add-Capability /CapabilityName:OpenSSH.Server~~~~0.0.1.0
)

echo starting ssh...
sc config sshd start=auto >nul
net start sshd >nul 2>&1

echo opening firewall port 22...
netsh advfirewall firewall add rule name="OpenSSH Server (sshd)" dir=in action=allow protocol=TCP localport=22 >nul

echo generating ssh key...
set KEY_PATH=%USERPROFILE%\.ssh\id_rsa

IF EXIST "%KEY_PATH%" (
    echo key exists, skipping generation.
) ELSE (
    ssh-keygen -t rsa -b 2048 -f "%KEY_PATH%" -N ""
)

echo saving key to desktop...
copy "%KEY_PATH%" "%DESKTOP%\ssh_private_key.txt" >nul

echo Setting up authorized_keys...
mkdir "%USERPROFILE%\.ssh" 2>nul
type "%KEY_PATH%.pub" >> "%USERPROFILE%\.ssh\authorized_keys"

:: fix perm*
icacls "%USERPROFILE%\.ssh" /inheritance:r >nul
icacls "%USERPROFILE%\.ssh" /grant:r "%USERNAME%:F" >nul
icacls "%USERPROFILE%\.ssh\authorized_keys" /inheritance:r >nul
icacls "%USERPROFILE%\.ssh\authorized_keys" /grant:r "%USERNAME%:F" >nul

echo removing password login...
powershell -Command ^
"(Get-Content 'C:\ProgramData\ssh\sshd_config') -replace '#PasswordAuthentication yes','PasswordAuthentication no' | Set-Content 'C:\ProgramData\ssh\sshd_config'"
net stop sshd >nul
net start sshd >nul

echo.
echo done
echo Private key saved at:
echo %DESKTOP%\ssh_private_key.txt
echo.
echo Connect using:
echo ssh %USERNAME%@YOUR_IP -i ssh_private_key.txt

pause
