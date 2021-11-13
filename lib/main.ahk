Main() {
    global
    static _ := Main()
    BuildGui()
    hwnd := WinExist(init.window)
    mem := new _ClassMemory(init.window, "", hProcessCopy) 
    _Memory(mem)
    addr := new MemAddr(mem)
    while true {
        st := A_TickCount
        if (!base := mem.read(mem.baseAddress))
            break

        bagOpen := mem.read(mem.baseAddress + addr.BagOpen_Base)
        
        MyHP := mem.read(addr.HPAddr, "Int"), MaxHP := mem.read(addr.HPAddr+4, "Int")
        MyHPPercent := MyHP ? Round(MyHP/MaxHP*100, 2) : "Unknow"

        MyMP := mem.read(addr.MPAddr, "Int"), MaxMP := mem.read(addr.MPAddr+4, "Int")
        MyMPPercent := MyMP ? Round(MyMP/MaxMP*100, 2) : "Unknow"
        
        MyPosition_X := mem.read(addr.MyPosition_XAddr, "Int")
        MyPosition_Y := mem.read(addr.MyPosition_YAddr, "Int")

        if UpdateAlarmer(MyHP, MaxHP, MyHPPercent, MyMP, MaxMP, MyMPPercent, BagOpen) or Stop {
            sleep 500
            (!Stop) ? addr := new MemAddr(mem)
            Continue
        }

        AutoCast()
        MoveingTo(MyPosition_X, MyPosition_Y, TargetPos_X, TargetPos_Y, LimitRange_X, LimitRange_Y)
        
        SendSpace ? (SendKey("space"), SendKey("F"))
        SendQ ? SendKey("Q")
        sleep % T := (A_TickCount-st>340) ? 10 : (340-(A_TickCount-st))
    }
    Msgbox % init.window " closed!"
    ExitApp
}

_Memory(obj) {
    if !isObject(obj)  {
        msgbox failed to open a handle
        if (hProcessCopy = 0)
            msgbox The program isn't running (not found) or you passed an incorrect program identifier parameter. 
        else if (hProcessCopy = "")
            msgbox OpenProcess failed. If the target process has admin rights, then the script also needs to be ran as admin. Consult A_LastError for more information.
        ExitApp
    }
}
