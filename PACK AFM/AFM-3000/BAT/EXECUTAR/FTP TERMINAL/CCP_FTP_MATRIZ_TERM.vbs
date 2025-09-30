Set objShell = CreateObject("WScript.Shell")
command = "powershell.exe -Command Start-Process 'C:\AFM-3000\BAT\FTP\BAT_FTP_TERM\CRIA ATALHO FTP_MATRIZ_TERM.BAT' -Verb RunAs -WindowStyle Hidden"
objShell.Run command, 0, False