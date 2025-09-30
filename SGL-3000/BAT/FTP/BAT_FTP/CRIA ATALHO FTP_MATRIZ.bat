@echo off

REM Valida RunTime
if exist "C:\runtime\" (
    goto continua
) else (
msg * "ESTE COMPUTADOR NAO EH UM SERVIDOR! NAO POSSUI PASTA RUNTIME! CONFIRME A EXECUCAO DOS AGENDAMENTOS CORRETOS FTP_TERMINAL"    
exit
)

:continua
REM Copiar para STARTUP DO WINDOWS:
xcopy "C:\SGL-3000\BAT\EXECUTAR\FTP SERVIDOR\CCP_FTP_MATRIZ_SERV.vbs" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup" /y

REM Definir os caminhos do arquivo .bat no servidor C:
set "bat1_path=C:\SGL-3000\BAT\FTP\BAT_FTP\FTP_MATRIZ.bat"

REM EXCLUI ROTINA AGENDADOR DE TAREFAS CCP_FTP_MATRIZ
schtasks /delete /tn "CCP_FTP_MATRIZ" /f

REM Criar uma tarefa no Agendador de Tarefas com privilégios elevados:
schtasks /create /tn "CCP_FTP_MATRIZ" /tr "C:\SGL-3000\BAT\FTP\BAT_FTP\FTP_MATRIZ.vbs" /sc hourly /st 00:00 /RL HIGHEST /f

REM Definir os nomes dos atalhos:
set "shortcut1_name=FTP_MATRIZ.lnk"

REM Definir o local da área de trabalho do usuário:
set "desktop_path=%USERPROFILE%\Desktop"

REM Definir o caminho do ícone personalizado:
set "icon_path=C:\SGL-3000\BAT\FTP\ICONCCP.ico"

REM Criar o atalho usando WScript:
(
echo Set objShell = CreateObject^("WScript.Shell"^)
echo Set objShortcut = objShell.CreateShortcut^("%desktop_path%\%shortcut1_name%"^)
echo objShortcut.TargetPath = "%bat1_path%"
echo objShortcut.WorkingDirectory = "C:\SGL-3000\BAT\FTP\BAT_FTP"
echo objShortcut.IconLocation = "%icon_path%"
echo objShortcut.Save
) > "%TEMP%\CreateShortcut1.vbs"

REM Executar o script VBScript em modo silencioso:
cscript //B //nologo "%TEMP%\CreateShortcut1.vbs"

REM Limpar o arquivo temporário:
del "%TEMP%\CreateShortcut1.vbs"

REM Definir caminho para a pasta Startup do Windows
set "startup_path=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"

REM Verificar e excluir CCP_FTP_FILIAL_VENDAS_SERV.vbs
if exist "%startup_path%\CCP_FTP_FILIAL_VENDAS_SERV.vbs" (
    del "%startup_path%\CCP_FTP_FILIAL_VENDAS_SERV.vbs"
)

REM Verificar e excluir CCP_FTP_FILIAL_SERV.vbs
if exist "%startup_path%\CCP_FTP_FILIAL_SERV.vbs" (
    del "%startup_path%\CCP_FTP_FILIAL_SERV.vbs"
)

REM Definir caminho para a área de trabalho do usuário logado
set "desktop_path=%USERPROFILE%\Desktop"

REM Verificar e excluir o atalho FTP_FILIAL_VENDAS.lnk da área de trabalho
if exist "%desktop_path%\FTP_FILIAL_VENDAS.lnk" (
    del "%desktop_path%\FTP_FILIAL_VENDAS.lnk"
)

REM Verificar e excluir o atalho FTP_FILIAL.lnk da área de trabalho
if exist "%desktop_path%\FTP_FILIAL.lnk" (
    del "%desktop_path%\FTP_FILIAL.lnk"
)

REM Verificar e excluir CCP_FTP_FILIAL_TERM.vbs
if exist "%startup_path%\CCP_FTP_FILIAL_TERM.vbs" (
    del "%startup_path%\CCP_FTP_FILIAL_TERM.vbs"
)

REM Verificar e excluir CCP_FTP_FILIAL_VENDAS_TERM.vbs
if exist "%startup_path%\CCP_FTP_FILIAL_VENDAS_TERM.vbs" (
    del "%startup_path%\CCP_FTP_FILIAL_VENDAS_TERM.vbs"
)

REM Verificar e excluir CCP_FTP_MATRIZ_TERM.vbs
if exist "%startup_path%\CCP_FTP_MATRIZ_TERM.vbs" (
    del "%startup_path%\CCP_FTP_MATRIZ_TERM.vbs"
)

REM EXCLUI ROTINA AGENDADOR DE TAREFAS CCP_FTP_FILIAL
schtasks /delete /tn "CCP_FTP_FILIAL" /f

REM EXCLUI ROTINA AGENDADOR DE TAREFAS CCP_FTP_FILIAL_VENDAS
schtasks /delete /tn "CCP_FTP_FILIAL_VENDAS" /f

REM Fechar automaticamente o CMD:
exit