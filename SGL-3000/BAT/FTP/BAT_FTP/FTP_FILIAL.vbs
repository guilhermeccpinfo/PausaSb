Set objShell = CreateObject("WScript.Shell")
command = "powershell.exe -Command Start-Process 'C:\SGL-3000\BAT\FTP\BAT_FTP\FTP_FILIAL.BAT' -Verb RunAs -WindowStyle Hidden"
objShell.Run command, 0, False