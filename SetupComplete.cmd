@echo off

REM === This file must be copied in C:\Windows\Setup\Scripts\ ===

REM === Enable RDP ===
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

REM === Disable NLA (optional but safer for first access) ===
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f

REM === Enable firewall rules for RDP ===
netsh advfirewall firewall set rule group="remote desktop" new enable=Yes

REM === Ensure Remote Desktop Services is running ===
sc config TermService start= auto
net start TermService

REM === Add user to Remote Desktop Users (just in case) ===
net localgroup "Remote Desktop Users" opc/add

REM === Log for debug ===
echo RDP enabled successfully > C:\rdp-setup.log