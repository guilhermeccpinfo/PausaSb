@echo off
cls
echo ==========================================================
echo              LIMPA AGENDAMENTOS BY CCPINFO
echo ======================== ATENCAO =========================
echo -------- UTILIZACAO EXCLUSIVA DO SUPORTE TECNICO ---------
echo ---- RISCO DE APAGAR TODOS OS ARQUIVOS DA SUA EMPRESA ----
echo.
echo ============== DIGITE A SENHA PARA INICIAR ===============

REM Captura a senha sem exibi-la na tela
for /f "delims=" %%p in ('powershell -Command "$pass = Read-Host 'Senha' -AsSecureString; [PSCredential]::new('user',$pass).GetNetworkCredential().Password"') do set "userInput=%%p"

REM Define a senha esperada
set "password=adm6000"

REM Verifica se a senha está correta
if "%userInput%"=="%password%" (
    echo INICIANDO LIMPEZA...
    timeout /t 3 >nul
) else (
    echo SENHA INCORRETA! O PROGRAMA SERA FECHADO!
    timeout /t 3 >nul
    exit /b
)

echo LIMPANDO TODAS AS ROTINAS DO AGENDADOR DE TAREFAS...
echo.

REM Lista de rotinas para verificar e excluir
set routines=CCP_LIMPEZA CCP_MSG_IMP CCP_REINICIAR CCP_RESTART_IMP CCP_FTP_MATRIZ CCP_FTP_FILIAL CCP_FTP_FILIAL_VENDAS CCP_CLOUD CCP_RESTART

for %%R in (%routines%) do (
    schtasks /query /tn "%%R" >nul 2>&1 && (
        schtasks /delete /tn "%%R" /f
        
    ) || (
        echo Rotina "%%R" nao encontrada...
    )
)

set StartupFolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

del "%StartupFolder%\AGD_CCP_CLOUD.vbs" /f /q
del "%StartupFolder%\AGD_CCP_FTP_FILIAL.vbs" /f /q
del "%StartupFolder%\AGD_CCP_FTP_FILIAL_VENDAS.vbs" /f /q
del "%StartupFolder%\AGD_CCP_FTP_MATRIZ.vbs" /f /q
del "%StartupFolder%\AGD_CCP_LIMPEZA.vbs" /f /q
del "%StartupFolder%\AGD_CCP_MSG_IMP.vbs" /f /q
del "%StartupFolder%\AGD_CCP_REINICIAR.vbs" /f /q
del "%StartupFolder%\AGD_CCP_RESTART_IMP.vbs" /f /q
del "%StartupFolder%\_Cria Atalho Suporte.bat" /f /q

echo Todas as rotinas do Agendador de Tarefas foram verificadas e processadas.
pause