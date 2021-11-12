;@Ahk2Exe-Obey               U_au, = "%A_IsUnicode%" ? 2 : 1
;@Ahk2Exe-PostExec           "BinMod.exe" "%A_WorkFileName%"
;@Ahk2Exe-Cont               "1%U_au%2.>AUTOHOTKEY SCRIPT<. BIGACHU           "
;@Ahk2Exe-Cont               "%U_au%.AutoHotkeyGUI.BIGACHU"
;@Ahk2Exe-PostExec           "BinMod.exe" "%A_WorkFileName%" "11.MPRESS.", 1, , 1, 1
;@Ahk2Exe-SetMainIcon        lib\icon\01.ico
;@Ahk2Exe-SetCompanyName     BIGACHU
;@Ahk2Exe-SetCopyright       Copyright © 2021. All rights reserved.
;@Ahk2Exe-SetDescription     BIGACHU
;@Ahk2Exe-SetInternalName    BIGACHU
;@Ahk2Exe-SetLegalTrademarks BIGACHU
;@Ahk2Exe-SetName            BIGACHU
;@Ahk2Exe-SetOrigFilename    BIGACHU
;@Ahk2Exe-SetProductName     BIGACHU
;@Ahk2Exe-SetVersion         1.1.0.0
;@Ahk2Exe-UpdateManifest     0 , BIGACHU

DetectHiddenWindows, On
DetectHiddenText, On
SetBatchLines, -1
SetTitleMatchMode, 3
#NoEnv
#SingleInstance, off
#Include <Includes>
#Include <main>
