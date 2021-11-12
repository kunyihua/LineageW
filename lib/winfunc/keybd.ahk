SendKey(key, prestime:=0) {
    global hwnd
    if prestime 
        ptime := prestime
    else 
        Random, ptime, 100, 200
    if (IsObject(key)) {
        for k, v in key {
            vk_code := GetKeyVK(v)
            DllCall("PostMessage", "UInt", hwnd, "UInt", 0x100, "UInt", vk_code, "UInt"
                , DllCall("MapVirtualKey", "UInt", vk_code, "UInt", 0))
        }
        sleep % ptime
        for k, v in key {
            vk_code := GetKeyVK(v)
            DllCall("PostMessage", "UInt", hwnd, "UInt", 0x101, "UInt", vk_code, "UInt"
                , DllCall("MapVirtualKey", "UInt", vk_code, "UInt", 0))
        }
    }
    else {      
        vk_code := GetKeyVK(key)  
        DllCall("PostMessage", "UInt", hwnd, "UInt", 0x100, "UInt", vk_code, "UInt"
                , DllCall("MapVirtualKey", "UInt", vk_code, "UInt", 0))
        sleep % ptime
        DllCall("PostMessage", "UInt", hwnd, "UInt", 0x101, "UInt", vk_code, "UInt"
            , DllCall("MapVirtualKey", "UInt", vk_code, "UInt", 0))
    }
    sleep 100
}