Set objShell = CreateObject("WScript.Shell")
command = "powershell.exe -Command Start-Process 'C:\SGL-3000\BAT\FTP\BAT_FTP\CRIA ATALHO FTP_FILIAL_VENDAS.BAT' -Verb RunAs -WindowStyle Hidden"
objShell.Run command, 0, False