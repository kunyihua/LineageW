UpdateAlarmer(MyHP, MaxHP, MyHPPercent, MyMP, MaxMP, MyMPPercent, bagOpen) {
    global GuiMaxLoop
    if (MyHP<=-1 or MaxHP>=99999 or !MaxHP or MyHPPercent<=-1 or MyHPPercent>100)
    or (MyMP<=-1 or MaxMP>=99999 or !MaxMP or MyMPPercent<=-1 or MyMPPercent>100 or (MyHP=1 and MaxMP=1))
    or (BagOpen) {
        tx := BagOpen ? "waiting for close bag" : "Reading data"
        GuiControl, , HPBar, 100
        GuiControl, , HPTX, % tx
        GuiControl, , MPBar, 100
        GuiControl, , MPTX, % tx
        sleep 1000
        return 1
    }
    else {
        GuiControl, , HPBar, % MyHPPercent
        GuiControl, , HPTX, % "HP: " MyHP " / " MaxHP "  ( " MyHPPercent "`% )"
        GuiControl, , MPBar, % MyMPPercent
        GuiControl, , MPTX, % "MP: " MyMP " / " MaxMP "  ( " MyMPPercent "`% )"
        Loop, % GuiMaxLoop-1 {
            CD := CD_%A_index%-Round((A_TickCount-KeyCD%A_index%)/1000, 0)
            if (CD>=0) {
                GuiControl, , CDTX_%A_index% , % "CD ( " CD " )"
                Guicontrol, +cRed +Redraw, CDTX_%A_index%
            }
            else if (CD<0) {
                GuiControl, , CDTX_%A_index% , % "ColdDown"
                Guicontrol, +cFFFFFF +Redraw, CDTX_%A_index%
            }
        }
    }
}

AutoCast() {
    global
    HpSort := ""
    Loop, % GuiMaxLoop-1 
        CB_%A_index% ? HpSort.= HP_%A_index% "," A_index "|"
    HpSorted := RTrim(HpSort, "|")
    Sort, HpSorted , N D|
    for k, v in HpArray := Strsplit(HpSorted, "|") {
        THP := Strsplit(v, ",")
        num := THP[2]
        if (MyHPPercent<=HP_%num% and MyMPPercent>=MP_%num%) {
            if (A_TickCount-KeyCD%num%>=CD_%num%*1000) {
                KeyCD%num% := A_TickCount
                SendKey(PK_%num%)
                break
            }
        }
    }
    if (CB_%GuiMaxLoop% and MyHPPercent<=HP_%GuiMaxLoop% and MyMPPercent>=MP_%GuiMaxLoop%)
        AlarmME(HP_%GuiMaxLoop%)
}

AlarmME(SetHP) {
    WinActivate, % init.window
    Loop, 3 {
        SoundBeep, 800, 500
        sleep 500
    }
    formattime, nowtime,, yyyy-MM-dd HH:mm:ss 
    MsgBox, 0x30, % init.window, % "HP is lower than " SetHP "`%!`n`n" nowtime
}