#Requires AutoHotkey v2.0
#SingleInstance Force

full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run '*RunAs "' A_ScriptFullPath '" /restart'
        else
            Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
    }
    ExitApp
}

achk := "continueHotkey"
acc := "continueClicks"

currentHK := RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\FMACsettings", achk, "^L")
clicks := RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\FMACsettings", acc, 1)

myGui := Gui()
myGui.Add("Text",, "Choose your FM Auto-continue shortcut:")
myGui.Add("Hotkey","vChosenHotkey", currentHK)
MyGui.Add("Text",,"Amount of clicks to perform:")
MyGui.Add("Edit")
MyGui.Add("UpDown", "vClicksSetter Range1-20", clicks)
button := myGui.Add("button","Default w80","Apply changes")
button.OnEvent("Click", onClick)
Hotkey currentHK, autocontinue
myGui.show()

autocontinue(*)
{
    MsgBox "clicked"
    currentWindow := WinGetID("A")
    fmWindow := WinExist("Football Manager 2023")
    MouseGetPos &xpos, &ypos

    if (fmWindow != 0){
        global clicks
        WinActivate fmWindow
        WinGetPos &xwin, &ywin, &width, &height, fmWindow
        MouseMove (xwin+width*0.95), (ywin+height*0.05)
        MouseClick "left",,,clicks
        WinActivate currentWindow
        MouseMove xpos, ypos
    }
}

onClick(*)
{
    global clicks
    global currentHK
    Hotkey currentHK, "off"
    currentHK := myGui['ChosenHotkey'].value
    Hotkey currentHK, autocontinue
    clicks := myGui['ClicksSetter'].value
    saveSettings(currentHK, clicks)
    MsgBox ("Settings saved!")
}

saveSettings(hk, c)
{
    global achk
    global acc
    RegWrite hk, "REG_SZ", "HKEY_LOCAL_MACHINE\SOFTWARE\FMACsettings", achk
    RegWrite c, "REG_DWORD", "HKEY_LOCAL_MACHINE\SOFTWARE\FMACsettings", acc
}