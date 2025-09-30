Set objShell = CreateObject("WScript.Shell")
command = "powershell.exe -Command Start-Process 'C:\AFM-3000\BAT\FTP\BAT_FTP\FTP_MATRIZ.BAT' -Verb RunAs -WindowStyle Hidden"
objShell.Run command, 0, False