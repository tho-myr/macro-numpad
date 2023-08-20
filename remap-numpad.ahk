#SingleInstance Force

SetTitleMatchMode RegEx ;allow regex match to window titles

;toggle between upper- & lowercase
isLowercase := false
!F23::
    Clipboard =
    Send ^c
    ClipWait, 0
    If isLowercase
        SendInput % Format("{Text}{:U}", Clipboard)
    Else
        SendInput % Format("{Text}{:L}", Clipboard)
    isLowercase := !isLowercase
return

;Outlook Switcher/Starter
F14::
    if WinActive("Kalender - .*") and WinActive(".*- Outlook")
    {
    	Send ^{1}
    }
    else if WinActive(".*- Outlook")
    {
    	Send ^{2}
    } else {
        if WinExist(".*- Outlook") {
            WinActivate ; Use the window found by WinExist.
        } else {
            Run C:\Program Files (x86)\Microsoft Office\Office16\OUTLOOK.EXE
        }
    }
return

;Open Teams Search
F1::
    if WinExist(".*\| Microsoft Teams") {
        WinActivate ;
	Send ^e
    }
return

!F24::
    if WinExist(".*\| Microsoft Teams") {
        WinActivate ;
	Send ^e
    }
return