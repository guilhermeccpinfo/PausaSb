@echo off
REM Configurar o tamanho da janela CMD
mode con: cols=160 lines=40


REM Exclui Criador de Atalhos duplicados
set "startup_path=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "current_file=%~nx0"

for %%F in ("%startup_path%\*AFM*.bat" "%startup_path%\*SGL*.bat") do (
    if /I not "%%~nxF"=="%current_file%" del /F /Q "%%F"
)

REM Caminho do script original
set "script_path=%~dpnx0"

REM Caminho para a pasta de inicialização
set "startup_folder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

REM Copiar o script para a pasta de inicialização
copy "%script_path%" "%startup_folder%" >nul

REM Exibir mensagem de verificação
echo AFM-3000 by CCPinfo - Por favor aguarde, estamos verificando a conexao com o seu servidor...
echo -------------------------------------------------------------------------------------------
REM Aguardar 5 segundos antes de verificar o servidor
timeout /t 5 >nul

REM Verificar se o servidor Z: está acessível
if not exist Z:\ (
    echo.
    echo                            CCPINFO AVISO IMPORTANTE!!!
    echo -------------------------------------------------------------------------------------------
    echo                  FALHA NA CONEXAO COM O SEU SERVIDOR DA LOJA!!!
    echo -------------------------------------------------------------------------------------------
    echo                 NAO SERA POSSIVEL ACESSAR O SISTEMA DA CCPINFO
    echo -------------------------------------------------------------------------------------------
    echo                    RISCO DE EXCLUIR OS ATALHOS DOS SISTEMAS
    echo -------------------------------------------------------------------------------------------
    echo               1 - VERIFIQUE AS CONEXOES DE REDE, ROTEADOR, MODEM E SAT
    echo               2 - REINICIE ESTE COMPUTADOR E O SERVIDOR DA SUA EMPRESA
    echo               3 - LIGUE PRIMEIRO O SERVIDOR DA EMPRESA E DEPOIS OS TERMINAIS
    echo -------------------------------------------------------------------------------------------
    echo         SE O PROBLEMA PERSISTIR, SOLICITE A VISITA DE UM TECNICO DE INFORMATICA
    echo -------------------------------------------------------------------------------------------
    echo                                  11 3999-6000 
    echo ===========================================================================================
start "" /min "https://ccpinformatica.movidesk.com/Account/Login"
    echo             TECLE [R] PARA REINICIAR O COMPUTADOR OU [N] PARA SAIR
    choice /c RN /n >nul
    if errorlevel 2 (
        echo Saindo...
        exit
    ) else (
        echo Reiniciando o computador...
        shutdown /r /t 4
    )
    REM Aguardar antes de sair
    timeout /t 600 >nul
    exit
)

REM Defini nome do servidor (APLICACAO WINDEV)
for /f "tokens=2 delims==" %%A in ('wmic path Win32_LogicalDisk where "DeviceID='Z:'" get ProviderName /value ^| findstr "="') do set server_name=%%A
echo Nome do servidor: %server_name%

REM Definir os caminhos dos arquivos .exe no servidor Z:
set "exe1_path=Z:\AFM-3000\Gerencia.exe"
::set "exe2_path=Z:\AFM-3000\Boca.exe"
set "exe3_path=Z:\AFM-3000\Boca.exe"
set "exe4_path=\\%server_name%\C\SNGPC\SNGPC_32.exe"
set "exe5_path=Z:\CCPWIN\Gerencia.exe"
set "exe6_path=\\%server_name%\C\CCP_ERP\ccpPedido_Compra_auto\ccpPedido_Compra_auto.exe"
set "exe7_path=\\%server_name%\C\CCP_ERP\MAT3\mat_3os.exe"

REM Definir os nomes dos atalhos
set "shortcut1_name=AFM GERENCIA.lnk"
::set "shortcut2_name=AFM CAIXA.lnk"
set "shortcut3_name=AFM TERMINAL.lnk"
set "shortcut4_name=AFM SNGP.lnk"
set "shortcut5_name=ERP GERENCIA.lnk"
set "shortcut6_name=ERP PEDIDOS.lnk"
set "shortcut7_name=ERP MAT_3OS.lnk"

REM Definir o local da área de trabalho do usuário
set "desktop_path=%USERPROFILE%\Desktop"

REM ATALHO GERENCIIA AFM
echo Set objShell = CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut1.vbs"
echo Set objShortcut = objShell.CreateShortcut("%desktop_path%\%shortcut1_name%") >> "%TEMP%\CreateShortcut1.vbs"
echo objShortcut.TargetPath = "%exe1_path%" >> "%TEMP%\CreateShortcut1.vbs"
echo objShortcut.WorkingDirectory = "Z:\AFM-3000" >> "%TEMP%\CreateShortcut1.vbs"
echo objShortcut.Save >> "%TEMP%\CreateShortcut1.vbs"
cscript //nologo "%TEMP%\CreateShortcut1.vbs"
del "%TEMP%\CreateShortcut1.vbs"

REM ATALHO CAIXA
echo Set objShell = CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut2.vbs"
echo Set objShortcut = objShell.CreateShortcut("%desktop_path%\%shortcut2_name%") >> "%TEMP%\CreateShortcut2.vbs"
echo objShortcut.TargetPath = "%exe2_path%" >> "%TEMP%\CreateShortcut2.vbs"
echo objShortcut.WorkingDirectory = "Z:\AFM-3000" >> "%TEMP%\CreateShortcut2.vbs"
echo objShortcut.Save >> "%TEMP%\CreateShortcut2.vbs"
cscript //nologo "%TEMP%\CreateShortcut2.vbs"
del "%TEMP%\CreateShortcut2.vbs"

REM ATALHO TERMINAL
echo Set objShell = CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut3.vbs"
echo Set objShortcut = objShell.CreateShortcut("%desktop_path%\%shortcut3_name%") >> "%TEMP%\CreateShortcut3.vbs"
echo objShortcut.TargetPath = "%exe3_path%" >> "%TEMP%\CreateShortcut3.vbs"
echo objShortcut.WorkingDirectory = "Z:\AFM-3000" >> "%TEMP%\CreateShortcut3.vbs"
echo objShortcut.Save >> "%TEMP%\CreateShortcut3.vbs"
cscript //nologo "%TEMP%\CreateShortcut3.vbs"
del "%TEMP%\CreateShortcut3.vbs"

REM ATALHO SNGPC
echo Set objShell = CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut4.vbs"
echo Set objShortcut = objShell.CreateShortcut("%desktop_path%\%shortcut4_name%") >> "%TEMP%\CreateShortcut4.vbs"
echo objShortcut.TargetPath = "%exe4_path%" >> "%TEMP%\CreateShortcut4.vbs"
echo objShortcut.WorkingDirectory = "%server_name%\C\SNGPC" >> "%TEMP%\CreateShortcut4.vbs"
echo objShortcut.Save >> "%TEMP%\CreateShortcut4.vbs"
cscript //nologo "%TEMP%\CreateShortcut4.vbs"
del "%TEMP%\CreateShortcut4.vbs"

REM ATALHO GERENCIA ERP
echo Set objShell = CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut5.vbs"
echo Set objShortcut = objShell.CreateShortcut("%desktop_path%\%shortcut5_name%") >> "%TEMP%\CreateShortcut5.vbs"
echo objShortcut.TargetPath = "%exe5_path%" >> "%TEMP%\CreateShortcut5.vbs"
echo objShortcut.WorkingDirectory = "Z:\CCPWIN" >> "%TEMP%\CreateShortcut5.vbs"
echo objShortcut.Save >> "%TEMP%\CreateShortcut5.vbs"
cscript //nologo "%TEMP%\CreateShortcut5.vbs"
del "%TEMP%\CreateShortcut5.vbs"

REM ATALHO PEDIDO DE COMPRA
echo Set objShell = CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut6.vbs"
echo Set objShortcut = objShell.CreateShortcut("%desktop_path%\%shortcut6_name%") >> "%TEMP%\CreateShortcut6.vbs"
echo objShortcut.TargetPath = "%exe6_path%" >> "%TEMP%\CreateShortcut6.vbs"
echo objShortcut.WorkingDirectory = "%server_name%\C\CCP_ERP\ccpPedido_Compra_auto" >> "%TEMP%\CreateShortcut6.vbs"
echo objShortcut.Save >> "%TEMP%\CreateShortcut6.vbs"
cscript //nologo "%TEMP%\CreateShortcut6.vbs"
del "%TEMP%\CreateShortcut6.vbs"

REM ATALHO MAT3_OS
echo Set objShell = CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut7.vbs"
echo Set objShortcut = objShell.CreateShortcut("%desktop_path%\%shortcut7_name%") >> "%TEMP%\CreateShortcut7.vbs"
echo objShortcut.TargetPath = "%exe7_path%" >> "%TEMP%\CreateShortcut7.vbs"
echo objShortcut.WorkingDirectory = "%server_name%\C\CCP_ERP\MAT3" >> "%TEMP%\CreateShortcut7.vbs"
echo objShortcut.Save >> "%TEMP%\CreateShortcut7.vbs"
cscript //nologo "%TEMP%\CreateShortcut7.vbs"
del "%TEMP%\CreateShortcut7.vbs"

REM Exibir mensagem de conclusão
echo Atalhos criados com sucesso!

REM Fechar automaticamente o CMD
exit