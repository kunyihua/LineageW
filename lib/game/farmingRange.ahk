MoveingTo(MyX, MyY, TX, TY, LR_X, LR_Y) {
    /*
        MyX = MyPosition X
        MyY = MyPosition Y
        TX = Target position X
        TY = Target position Y
        LR_X = Limit Range X
        LR_Y = Limit Range Y
    */ 
    global Moving ; Gui switch control
    static lastMove := 0
    GuiControl, , MyPosition_X, % MyX
    GuiControl, , MyPosition_Y, % MyY
    if (abs(MyX-TX)>(LR_X+20) or abs(MyY-TY)>(LR_Y+20)) {
        GuiControl, , PositionTX, % "#Warning: Out of range"
        return
    }
    else {
        GuiControl, , PositionTX, % "Range X: " abs(MyX-TX) ", Y: " abs(MyY-TY)
    }
    if (Moving and A_tickcount-lastMove>700 
    and (MyX-TX>LR_X or TX-MyX>LR_X or MyY-TY>LR_Y or TY-MyY>LR_Y)) {
        key := []
        if (MyX-TX>LR_X) {
            key.push("A")
            (MyY-TY>2) ? key.push("W") : (TY-MyY>2) ? key.push("S")
        }
        else if (TX-MyX>LR_X) {
            key.push("D")
            (MyY-TY>2) ? key.push("W") : (TY-MyY>2) ? key.push("S")
        }
        else if (MyY-TY>LR_Y) {
            key.push("W")
            (MyX-TX>2) ? key.push("A") : (TX-MyX>2) ? key.push("D")
        }
        else if (TY-MyY>LR_Y) {
            key.push("S")
            (MyX-TX>2) ? key.push("A") : (TX-MyX>2) ? key.push("D")
        }
        GuiControl, , PositionTX, % "Moving " key[1] " " key[2]
        Sendkey(key, 800)
        GuiControl, , PositionTX, % ""
        lastMove := A_TickCount
    }
}

SetFarmingPos() {
    global MyPosition_X, MyPosition_Y
    GuiControl, , TargetPos_X, % MyPosition_X
    GuiControl, , TargetPos_Y, % MyPosition_Y
    GetGui()
}
