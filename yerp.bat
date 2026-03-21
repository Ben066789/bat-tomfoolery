@echo off

:: ss
powershell -command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $bmp = New-Object System.Drawing.Bitmap([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height); $graphics = [System.Drawing.Graphics]::FromImage($bmp); $graphics.CopyFromScreen(0,0,0,0,$bmp.Size); $bmp.Save('$env:USERPROFILE\desktop_prank.png');"

:: set walp
powershell -command "Add-Type -TypeDefinition @'
using System.Runtime.InteropServices;
public class Wallpaper {
  [DllImport(\"user32.dll\", SetLastError = true)]
  public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
'@; [Wallpaper]::SystemParametersInfo(20, 0, '$env:USERPROFILE\desktop_prank.png', 3)"

:: hide desk ico
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideIcons /t REG_DWORD /d 1 /f

:: restart
taskkill /f /im explorer.exe
start explorer.exe

:: Auto-hide taskbar
powershell -command "$p='HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'; $v=(Get-ItemProperty $p).Settings; $v[8]=3; Set-ItemProperty $p Settings $v; Stop-Process -f -ProcessName explorer"

exit