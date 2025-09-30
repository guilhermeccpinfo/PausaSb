Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")

' Caminho de origem do arquivo
sourceFile = "C:\AFM-3000\BAT\EXECUTAR\CCP_AGENDADORES_TERMINAL.vbs"

' Caminho da pasta de inicialização (Startup)
startupFolder = objShell.ExpandEnvironmentStrings("%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup")
destinationFile = startupFolder & "\CCP_AGENDADORES_TERMINAL.vbs"

' Copia o arquivo diretamente, sem verificação de existência
objFSO.CopyFile sourceFile, destinationFile, True

' Primeiro comando
command = "powershell.exe -Command Start-Process 'C:\AFM-3000\BAT\AGD.BAT\CCP_AGENDADORES_TERMINAL.BAT' -Verb RunAs -WindowStyle Hidden"
objShell.Run command, 0, False
WScript.Sleep 10000 ' Espera 10 segundos (10.000 milissegundos)

' Segundo comando
command = "powershell.exe -Command Start-Process 'C:\AFM-3000\BAT\Criar Atalho AFM\_Cria Atalho Suporte.BAT' -Verb RunAs -WindowStyle Hidden"
objShell.Run command, 0, False
WScript.Sleep 10000 ' Espera 10 segundos (10.000 milissegundos)

' Terceiro comando
command = "powershell.exe -Command Start-Process 'C:\AFM-3000\BAT\WIN\CCP_ATUALIZA_TERMINAL.vbs' -WindowStyle Hidden"
objShell.Run command, 0, False
WScript.Sleep 10000 ' Espera 10 segundos (10.000 milissegundos)

' Quarto comando - Remove arquivos específicos da pasta Startup
Set fso = CreateObject("Scripting.FileSystemObject")
Set startupDir = fso.GetFolder("C:\Users\" & CreateObject("WScript.Network").UserName & "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup")

For Each file In startupDir.Files
    If file.Name = "CCP_AGENDADORES_SERVIDOR.vbs" Or file.Name = "CCP_AGENDADORES.vbs" Then
        file.Delete True
    End If
Next