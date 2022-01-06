#NoEnv
SetKeyDelay, 0
; v0.4.0-beta

if (%7%)
  SoundPlay, reset.wav

ControlSend, ahk_parent, {Blind}{Shift down}{Tab}{Shift up}{Enter}, ahk_pid %1%
sleep, 1000
while (True) {
  FileDelete, %8%
  if (ErrorLevel == 0)
    ExitApp
  WinGetTitle, title, ahk_pid %1%
  if (InStr(title, " - "))
    break
}

while (True) {
  FileDelete, %8%
  if (ErrorLevel == 0)
    ExitApp
  numLines := 0
  Loop, Read, %2%
  {
    numLines += 1
  }
  saved := False
  Loop, Read, %2%
  {
    if ((numLines - A_Index) < 5)
    {
      if (InStr(A_LoopReadLine, "Loaded 0") || (InStr(A_LoopReadLine, "Saving chunks for level 'ServerLevel") && InStr(A_LoopReadLine, "minecraft:the_end"))) {
        saved := True
        break
      }
    }
  }
  if (saved || A_Index > %3%)
    break
}
sleep, %6%
WinGet, activePID, PID, A
if activePID != %1%
  ControlSend, ahk_parent, {Blind}{F3 Down}{Esc}{F3 Up}, ahk_pid %1%
sleep, %4%
FileAppend,, %5%
ExitApp
