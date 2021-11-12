class init {

    __New() {
        this.window := ""
        lineageWin := "i)天堂W l |Lineage W l |리니지W l |リネージュW l "
        WinGet windows, List
        loop, % windows {
            WinGetTitle, win, % "ahk_id " windows%A_index%
            if RegEXMatch(win, lineageWin) {
                this.window := win
                break
            }
        }
        this.ScriptName := RegExReplace(this.window, lineageWin)
        this.setting_name := "settings.ini"
        this.setting_Section := this.ScriptName
        if WinExist(this.ScriptName) {
            WinActivate, % this.ScriptName
            ExitApp
        }
        Menu, Tray, NoStandard
        Menu, Tray, Tip , % this.ScriptName
    }

}

BuildGui() {
    global
    init := new init()
    WinGet, PID, PID, % "ahk_id " . Win_Hwnd := WinExist(init.window)
    Gui, 1:New, +Owner%Win_Hwnd% +Hwndowned +ToolWindow -Caption +Border
    Gui, 1:Font, s12 w800, Arial
    Gui, 1:Color, 0x171717, 0x171717
    Gui, 1:Add, Progress, x10 y10 w540 h25 Disabled cF9878E vHPBar , 100
    Gui, 1:Add, Text, x10 y10 w540 h25 vHPTX 0x201 +Border BackgroundTrans, 
    Gui, 1:Add, Progress, x10 y+10 w540 h25 Disabled c9DC1FF vMPBar , 100
    Gui, 1:Add, Text, x10 yp w540 h25 vMPTX 0x201 +Border BackgroundTrans, 
    Gui, 1:Font, s12 w500 cFFFFFF, Arial 

    Gui, 1:Add, GroupBox, x10 y80 w540 h220, Alarmer
    x := 20, y := 110
    GuiMaxLoop := 5
    Loop, % GuiMaxLoop {
        if (A_index=GuiMaxLoop) {
            Gui, 1:Add, checkbox, x%x% y%y% vCB_%A_index% gGetGui, HP<=
            Gui, 1:Add, edit, x+0 yp-3 w40 number limit3 vHP_%A_index% gGetGui, 80
            Gui, 1:Add, text, x+1 yp+4, `% MP>=
            Gui, 1:Add, edit, x+10 yp-3 w40 number limit3 vMP_%A_index% gGetGui, 80
            Gui, 1:Add, text, x+1 yp+4, `% Alarm me!
        }
        else {
            Gui, 1:Add, checkbox, x%x% y%y% vCB_%A_index% gGetGui, HP<=
            Gui, 1:Add, edit, x+0 yp-3 w40 number limit3 vHP_%A_index% gGetGui, 80
            Gui, 1:Add, text, x+1 yp+4, `% MP>=
            Gui, 1:Add, edit, x+10 yp-3 w40 number limit3 vMP_%A_index% gGetGui, 80
            Gui, 1:Add, text, x+1 yp+4, `% PressKey
            Gui, 1:Add, DDL, x+10 yp-3 w40 vPK_%A_index% gGetGui, 1||2|3|4|5|6|7|8
            Gui, 1:Add, text, x+4 yp+4 vCDTX_%A_index%, ColdDown
            Gui, 1:Add, edit, x+10 yp-3 w40 number limit3 vCD_%A_index% gGetGui, 5
            Gui, 1:Add, text, x+1 yp+4 , Sec
        }
        KeyCD%A_index% := 0
        y += 40
    }

    
    Gui, 1:Add, GroupBox, x10 y310 w540 h120, FarmingRange
    x := 20, y := 340

    Gui, 1:Add, checkbox, x%x% y%y% vMoving gGetGui, Enable
    Gui, 1:Add, text, x+30 yp, X
    Gui, 1:Add, text, x+60 yp, Y

    Gui, 1:Add, text, x%x% y+10, TargetPos
    Gui, 1:Add, edit, x+16 yp-3 w60 ReadOnly vTargetPos_X gGetGui, 0
    Gui, 1:Add, edit, x+10 yp w60 ReadOnly vTargetPos_Y gGetGui, 0
    Gui, 1:Add, text, x+10 yp+3, Range X Y
    Gui, 1:Add, edit, x+10 yp-3 w50 ReadOnly vLimitRange_X gGetGui, 5
    Gui, 1:Add, UpDown, Range1-30 gGetGui, 5
    Gui, 1:Add, edit, x+10 yp w50 ReadOnly vLimitRange_Y gGetGui, 5
    Gui, 1:Add, UpDown, Range1-30 gGetGui, 5
    Gui, 1:Add, Button, x+10 yp+1 w60 h23 gSetFarmingPos, Set

    Gui, 1:Add, text, x%x% y+10, MyPosition
    Gui, 1:Add, edit, x+10 yp-3 w60 ReadOnly vMyPosition_X, 0
    Gui, 1:Add, edit, x+10 yp w60 ReadOnly vMyPosition_Y, 0
    Gui, 1:Add, text, x+10 yp+3 w200 vPositionTX, 
    
    Gui, 1:Add, checkbox, x10 y+20 gGetGui vStop, Pause
    Gui, 1:Add, checkbox, x+10 yp gGetGui vSendSpace, SendSpace
    Gui, 1:Add, checkbox, x+10 yp gGetGui vSendQ, SendQ
    Gui, 1:Add, text, x+10 yp , Hotkey: Alt+E/Q
    Gui, 1:Add, Button, x+20 yp w100 h20 gGuiClose, ExitApp

    ownerAhkId := "ahk_id " . Win_Hwnd, ownedAhkId := "ahk_id " . owned
    Gui, 1:Show, w560, % init.ScriptName
    WinSet, Trans, 210, % "ahk_id " owned
    GuiController.GuiLoad(init.setting_name, init.setting_Section, init.ScriptName)
    hWinEventHook := SetWinEventHook("0x800B", "0x800B", 0, RegisterCallback("OnLocationChangeMonitor"), PID, 0, 0)
    OnLocationChangeMonitor(0, 0, 1)
    return
}

GetGui() {
    global
    Critical, On
    SetTimer, __GuiSave, -500
    Critical, off
    return

    __GuiSave:
    Critical, On
    Gui, 1:submit, Nohide
    GuiController.GuiSave(init.setting_name, init.setting_Section, init.ScriptName)
    Critical, off
    return
}

GuiClose() {
    global hWinEventHook
    UnhookWinEvent(hWinEventHook)
    ExitApp
}

_GuiShow() {
    global ownerAhkId, ownedAhkId
    Gui, 1:Show
    WinActivate, % init.window
    WinGetPos, _x, _y, ,, % ownerAhkId
    WinMove, % ownedAhkId,, % _x, % _y
}

_GuiHide() {
    Gui, 1:Hide
}

OnLocationChangeMonitor(_hWinEventHook, _event, _hwnd) { ; https://msdn.microsoft.com/en-us/library/windows/desktop/dd373885(v=vs.85).aspx
    global ownedAhkId, ownerAhkId
	_listLines := A_ListLines
	ListLines, Off
    if not (_hwnd) ; if the system sent the EVENT_OBJECT_LOCATIONCHANGE event for the caret: https://msdn.microsoft.com/en-us/library/windows/desktop/dd318066(v=vs.85).aspx
        return
    WinGetPos, _x, _y, ,, % ownerAhkId
    WinMove, % ownedAhkId,, % _x, % _y ; set the position of the window owned by owner
	ListLines % _listLines ? "On" : "Off"
}

SetWinEventHook(_eventMin, _eventMax, _hmodWinEventProc, _lpfnWinEventProc, _idProcess, _idThread, _dwFlags) {
   DllCall("CoInitialize", "Uint", 0)
   return DllCall("SetWinEventHook"
			, "Uint", _eventMin
			, "Uint", _eventMax
			, "Ptr", _hmodWinEventProc
			, "Ptr", _lpfnWinEventProc
			, "Uint", _idProcess
			, "Uint", _idThread
			, "Uint", _dwFlags)
} 

UnhookWinEvent(_hWinEventHook) {
    _v := DllCall("UnhookWinEvent", "Ptr", _hWinEventHook)
    DllCall("CoUninitialize")
    return _v
}