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

REM Defini nome do servidor
for /f "tokens=2 delims==" %%A in ('wmic path Win32_LogicalDisk where "DeviceID='Z:'" get ProviderName /value ^| findstr "="') do set server_name=%%A
echo Nome do servidor: %server_name%

REM Definir os caminhos dos arquivos .exe no servidor Z:
set "exe1_path=Z:\AFM-3000\Gerencia.exe"
set "exe2_path=Z:\AFM-3000\Boca.exe"
set "exe3_path=\\%server_name%\SNGPC\SNGPC_32.exe"

REM Definir os nomes dos atalhos
set "shortcut1_name=GERENCIA.lnk"
set "shortcut2_name=CAIXA12.lnk"
set "shortcut3_name=SNGPC.lnk"

REM Definir o local da área de trabalho do usuário
set "desktop_path=%USERPROFILE%\Desktop"

REM ATALHO GERENCIA
echo Set objShell = CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut1.vbs"
echo Set objShortcut = objShell.CreateShortcut("%desktop_path%\%shortcut1_name%") >> "%TEMP%\CreateShortcut1.vbs"
echo objShortcut.TargetPath = "%exe1_path%" >> "%TEMP%\CreateShortcut1.vbs"
echo objShortcut.WorkingDirectory = "Z:\AFM-3000" >> "%TEMP%\CreateShortcut1.vbs"
echo objShortcut.Save >> "%TEMP%\CreateShortcut1.vbs"
cscript //nologo "%TEMP%\CreateShortcut1.vbs"
del "%TEMP%\CreateShortcut1.vbs"

REM ATALHO CAIXA01
echo Set objShell = CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut2.vbs"
echo Set objShortcut = objShell.CreateShortcut("%desktop_path%\%shortcut2_name%") >> "%TEMP%\CreateShortcut2.vbs"
echo objShortcut.TargetPath = "%exe2_path%" >> "%TEMP%\CreateShortcut2.vbs"
echo objShortcut.WorkingDirectory = "Z:\AFM-3000" >> "%TEMP%\CreateShortcut2.vbs"
echo objShortcut.Save >> "%TEMP%\CreateShortcut2.vbs"
cscript //nologo "%TEMP%\CreateShortcut2.vbs"
del "%TEMP%\CreateShortcut2.vbs"

REM ATALHO SNGPC
echo Set objShell = CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut3.vbs"
echo Set objShortcut = objShell.CreateShortcut("%desktop_path%\%shortcut3_name%") >> "%TEMP%\CreateShortcut3.vbs"
echo objShortcut.TargetPath = "%exe3_path%" >> "%TEMP%\CreateShortcut3.vbs"
echo objShortcut.WorkingDirectory = "%server_name%\SNGPC" >> "%TEMP%\CreateShortcut3.vbs"
echo objShortcut.Save >> "%TEMP%\CreateShortcut3.vbs"
cscript //nologo "%TEMP%\CreateShortcut3.vbs"
del "%TEMP%\CreateShortcut3.vbs"

REM Exibir mensagem de conclusão
echo Atalhos criados com sucesso!

REM Fechar automaticamente o CMD
exit