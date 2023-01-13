#Requires AutoHotkey v2.0

myGui := Gui()
myGui.Add("Text",, "Choose your FM Auto-continue shortcut:")
global currentHK := "^L"
myGui.Add("Hotkey","vChosenHotkey", currentHK)
button := myGui.Add("button","Default w80","Apply shortcut")
button.OnEvent("Click", OnClick)
Hotkey currentHK, ac

ac(*){
    Run "fm_autocontinue.pyw"
}

OnClick(*)
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