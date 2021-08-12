echo OFF

netsh wlan show profiles
set /p prof=Which Profile would you like to see?  

echo You chose: %prof%
netsh wlan show profiles %prof% key=clear | findstr "Key Content"
