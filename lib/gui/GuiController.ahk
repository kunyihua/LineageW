Class GuiController {
	
	SaveWinPos(filename :="Settings.ini", Section:="WinPostition", wintitle :="A")	{
		WinGetpos, winx, winy,,, %wintitle%
		IniWrite , %winx%, %filename%, %Section%, winx
		IniWrite , %winy%, %filename%, %Section%, winy
	}
	
	LoadWinPos(filename :="Settings.ini", Section:="WinPostition", wintitle :="A")	{
		IniRead, winx, %filename%, %Section%, winx, -1
		IniRead, winy, %filename%, %Section%, winy, -1
		WinGetPos,,, Width, Height, %wintitle%
		winx := winx<0 ? (A_ScreenWidth/2)-(Width/2) : winx
		winy := winy<0 ? (A_ScreenHeight/2)-(Height/2) : winy
		winmove, %wintitle%,, %winx%, %winy%
		return [winx, winy]
	}
	
	GetGuiVname(wintitle) {
		WinGet, A_GUIs, ControlList, %wintitle%
		GUIs := []
		Loop, Parse, A_GUIs, `n
		{
			GuiControlGet, vname, Name, %A_Loopfield%
			if (vname!="") and !(InStr(A_Loopfield, "ListBox"))
				GUIs.push(vname)
		}
		return GUIs
	}

	GuiSave(filename :="Settings.ini", Section:="MySetting", wintitle :="A") 	{
		for k, var in Array := this.GetGuiVname(wintitle) {
			var2 := %var%
			if (var2!="ERROR") {
				var2 := StrReplace(var2, "`n", "\n")
				IniWrite , %var2%, %filename%, %Section%, %var%
			}
		}
	}

	GuiLoad(filename:="Settings.ini", Section:="MySetting", wintitle :="A")	{
		for k, var in Array := this.GetGuiVname(wintitle) {
			IniRead, var2, %filename%, %Section%, %var%, ERROR
			%var% = %var2%
			if (var2!="" and var2!="ERROR") {
				Guicontrol, ChooseString, %var%, %var2%
				if ErrorLevel {
					var2 := StrReplace(var2, "\n", "`n")
					Guicontrol, , %var%, %var2%
				}
			}
		}
	}
}