@echo off

:: Uncomment interfaceName and change example to whatever interface you want, otherwise it will ask everytime
:: set interfaceName=Ethernet 5

:: Static IP variables, feel free to change
set staticip1=192.168.0.69
set staticip1_subnet=255.255.255.0
set staticip1_str=192.168.0.69/24



::-------------------------------------
:: Check for Admin Priveleges
::  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

:: --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges to modify network...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
::--------------------------------------


:: Intro Message
echo. 
echo This script toggles a network interface between DHCP and static IP addresses

:: Ask which interface if not filled in
IF "%interfaceName%"=="" (
  echo.
  echo interfaceName variable not set.
  echo Please set it in this script or type desired interface to change from list: 
  netsh interface ip show interfaces
  set /P interfaceName=Enter Interface Name: 
  echo.
)

:: Announce options available and interface to be changed
echo Now setting interface "%interfaceName%"
echo Current available configurations:
echo     (1) DHCP
echo     (2) StaticIP1: %staticip1_str%
echo.
set /p response="type config number of your choice: "
echo.

IF /i "%response%"=="1" goto setDHCP
IF /i "%response%"=="2" goto setSTATICIP1

echo %response% is not a valid number. exiting
goto commonexit

:setDHCP
echo Setting "%interfaceName%" to DHCP config
netsh interface ip set address "%interfaceName%" dhcp
goto commonexit

:setSTATICIP1
echo Setting "%interfaceName%" to Static IP %staticip1_str%
netsh interface ip set address "%interfaceName%" static %staticip1% %staticip1_subnet%
goto commonexit

:commonexit
echo done changing Ethernet mode
echo.
pause
