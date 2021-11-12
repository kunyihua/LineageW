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
    GuiControl, , MyPosition_X, % MyX
    GuiControl, , MyPosition_Y, % MyY
    if (abs(MyX-TX)>(LR_X+20) or abs(MyY-TY)>(LR_Y+20)) {
        GuiControl, , PositionTX, % "#Warning: Out of range"
        return
    }
    else {
        GuiControl, , PositionTX, % "Range X: " abs(MyX-TX) ", Y: " abs(MyY-TY)
    }
    if (Moving and (MyX-TX>LR_X or TX-MyX>LR_X or MyY-TY>LR_Y or TY-MyY>LR_Y)) {
        sleep 500
        key := []
        if (MyX-TX>LR_X) {
            (MyY-TY>2) ? key.push("S")
            : (TY-MY>2) ? key.push("W")
            key.push("A")
        }
        else if (TX-MyX>LR_X) {
            (MyY-TY>2) ? key.push("S")
            : (TY-MY>2) ? key.push("W")
            key.push("D") 
        }
        else if (MyY-TY>LR_Y) {
            (MyX-TX>2) ? key.push("A") 
            : (TX-MyX>2) ?key.push("D")
            key.push("W")
        }
        else if (TY-MyY>LR_Y) {
            (MyX-TX>2) ? key.push("A") 
            : (TX-MyX>2) ?key.push("D")
            key.push("S") 
        }
        GuiControl, , PositionTX, % "Moving " key[1] " " key[2]
        Sendkey(key, 800)
        GuiControl, , PositionTX, % ""
    }
}

SetFarmingPos() {
    global MyPosition_X, MyPosition_Y
    GuiControl, , TargetPos_X, % MyPosition_X
    GuiControl, , TargetPos_Y, % MyPosition_Y
    GetGui()
}