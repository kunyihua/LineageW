Click(position) { ; not working
    global hwnd, mem
    if !IsObject(position)
        return

    mouse_inWindow := mem.Write(0x213E640DCB0, 1, "Int")
    mouse_x := mem.Write(0x213E09F83E8, position[1], "Int")
    mouse_y := mem.Write(0x213E09F83EC, position[2], "Int")

    x := position[1], y := position[2]
    lParam := x & 0xFFFF | (y & 0xFFFF) << 16
    DllCall("PostMessage", "UInt", hwnd, "UInt", 0x201, "UInt", 1, "UInt", lParam)
    DllCall("PostMessage", "UInt", hwnd, "UInt", 0x202, "UInt", 0, "UInt", lParam)
    sleep 500
}