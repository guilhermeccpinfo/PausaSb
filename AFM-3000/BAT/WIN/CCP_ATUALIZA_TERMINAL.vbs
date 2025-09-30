Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")

' Caminho de origem do arquivo
sourceFile = "C:\AFM-3000\BAT\WIN\CCP_ATUALIZA_TERMINAL.vbs"

' Caminho da pasta de inicialização (Startup)
startupFolder = objShell.ExpandEnvironmentStrings("%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup")
destinationFile = startupFolder & "\CCP_ATUALIZA_TERMINAL.vbs"

' Copia o arquivo diretamente, sem verificação de existência
objFSO.CopyFile sourceFile, destinationFile, True

' Executa o arquivo BAT
objShell.Run """C:\AFM-3000\BAT\WIN\CCP_ATUALIZA_TERMINAL.BAT""", 0, False

' Libera os objetos no final do script
Set objFSO = Nothing
Set objShell = Nothing