#SingleInstance, Force

file = %a_scriptdir%\numpad-profile-one.png ; Replace as needed
toggled = false

Gui, Color, 222222
Gui +LastFound +AlwaysOnTop +ToolWindow
;WinSet, TransColor, 222222   ;makes background transparent
;Gui, Maximize   ;makes gui fit window size but image isnt centered anymore
Gui, Add, Picture, Center, %file%
Gui -Caption

#N::
	if !toggled {
		Gui, Show, Center
	} else {
		Gui, Cancel
    }
	toggled := !toggled
return
