#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SoundGet,Volume
Volume:=Round(Volume)
TrayTip:="Win+F8 or Win+F9 to adjust volume" . "`nCurrent Volume: " . Volume
TrayIconFile:=A_WinDir . "System32DDORes.dll" ; get tray icon from DDORes.dll
TrayIconNum:="-2032" ; use headphones as tray icon (icon 2032 in DDORes)
Menu,Tray,Tip,%TrayTip%
; Menu,Tray,Icon,%TrayIconFile%,%TrayIconNum%
Return

#F8::
SetTimer,SliderOff,1000
SoundSet,-1
Gosub,DisplaySlider
Return

#F9::
SetTimer,SliderOff,1000
SoundSet,+1
Gosub,DisplaySlider
Return

SliderOff:
Progress,Off
Return

DisplaySlider:
SoundGet,Volume
Volume:=Round(Volume)
Progress,%Volume%,%Volume%,Volume,HorizontalVolumeSliderW10
TrayTip:="Win+LeftArrow or Win+RightArrow to adjust volume" . "`nCurrent Volume=" . Volume
Menu,Tray,Tip,%TrayTip%
Return
