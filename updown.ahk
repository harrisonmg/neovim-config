#SingleInstance Force
#IfWinActive ahk_class Chrome_WidgetWin_1
#IfWinActive ahk_class Chrome_WidgetWin_0
#IfWinActive ahk_exe   Chrome.exe
	^!n::Down
	^!p::Up
#IfWinActive