@echo OFF

echo.
echo =============================================================================
echo Shows Previously Entered Passwords from history of your connected Wifi SSIDs
echo =============================================================================
echo.
netsh wlan show profiles
set /p prof=Which Profile would you like to see?  

echo You chose: %prof%
netsh wlan show profiles "%prof%" key=clear | findstr "Key Content"
