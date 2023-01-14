#Requires AutoHotkey v2.0

myGui := Gui()
myGui.Add("Text",, "Choose your FM Auto-continue shortcut:")
currentHK := "^L"
clicks := 1
myGui.Add("Hotkey","vChosenHotkey", currentHK)
button := myGui.Add("button","Default w80","Apply shortcut")
button.OnEvent("Click", onClick)
Hotkey currentHK, ac

clickButton()
{
    currentWindow := WinGetID("A")
    fmWindow := WinExist("Football Manager 2023")
    MouseGetPos &xpos, &ypos

    if (fmWindow != 0){
        global clicks
        WinActivate fmWindow
        WinGetPos &xwin, &ywin, &width, &height, fmWindow
        MouseMove (xwin+width*0.98), (ywin+height*0.02)
        MouseClick "left",,,clicks
        MouseMove xpos, ypos
        WinActivate currentWindow
        MouseMove xpos, ypos
    }
}

ac(*){
    clickButton()
}

onClick(*)
{
    global currentHK
    Hotkey currentHK, "off"
    currentHK := myGui['ChosenHotkey'].value
    Hotkey currentHK, ac
    MsgBox ("Your new shortcut is " currentHK)
}

^P::
{
    myGui.show()
}