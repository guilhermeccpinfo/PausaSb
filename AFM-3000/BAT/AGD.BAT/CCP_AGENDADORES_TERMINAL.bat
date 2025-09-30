@echo off
REM Verifica privilégios administrativos
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ================================================================
    echo FALHA NOS PRIVILEGIOS ADM - CRIE O AGENDAMENTO MANUALMENTE!
    echo ================================================================
    pause
    exit /b
)

echo. ---------------------------------------------------------------------------------------------------------------------------------

REM Valida RunTime
if exist "C:\runtime\" (
msg * "ESTE COMPUTADOR EH UM SERVIDOR! POSSUI PASTA RUNTIME! CONFIRME A EXECUCAO DOS AGENDAMENTOS CORRETOS CCP_AGENDADORES_TERMINAL"
exit
) else (
    goto continua
)

:continua

echo. ---------------------------------------------------------------------------------------------------------------------------------

REM Definir caminho para a pasta Startup do Windows
set "startup_path=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"

REM Excluir CCP_AGENDADORES_SERVIDOR.vbs
del "%startup_path%\CCP_AGENDADORES_SERVIDOR.vbs"

REM Excluir CCP_AGENDADORES.vbs
del "%startup_path%\CCP_AGENDADORES.vbs"

echo. ---------------------------------------------------------------------------------------------------------------------------------

REM CCP_CLOUD

REM Deleta tarefa no Agendador de Tarefas
schtasks /delete /tn "CCP_CLOUD" /f

REM Deleta tarefa no Agendador de Tarefas
schtasks /delete /tn "CCP_BKP_SERVIDOR" /f

echo. ---------------------------------------------------------------------------------------------------------------------------------

REM CCP_BKP_TERMINAL

REM Deleta tarefa no Agendador de Tarefas
schtasks /delete /tn "CCP_BKP_TERMINAL" /f

REM Criação da tarefa no Agendador de Tarefas
schtasks /create /tn "CCP_BKP_TERMINAL" /tr "cmd /c start /min C:\AFM-3000\BAT\BKP\CCP_TERMINAL.bat" /sc daily /st 04:00 /f
timeout /t 10

echo. ---------------------------------------------------------------------------------------------------------------------------------

REM CCP_LIMPEZA

REM Deleta tarefa no Agendador de Tarefas
schtasks /delete /tn "CCP_LIMPEZA" /f

REM Criação da tarefa no Agendador de Tarefas
schtasks /create /tn "CCP_LIMPEZA" /tr "C:\AFM-3000\BAT\WIN\CCP_LIMPEZA.bat" /sc weekly /d MON /mo 1 /st 15:00 /ru SYSTEM /RL HIGHEST /f
timeout /t 10

echo. ---------------------------------------------------------------------------------------------------------------------------------

REM CCP_REINICIAR

REM Deleta tarefa no Agendador de Tarefas
schtasks /delete /tn "CCP_REINICIAR" /f

REM Criação da tarefa no Agendador de Tarefas
schtasks /create /tn "CCP_REINICIAR" /tr "shutdown.exe /r /f /t 0" /sc daily /st 01:00 /ru SYSTEM /RL HIGHEST 
timeout /t 10

echo. ---------------------------------------------------------------------------------------------------------------------------------

REM CCP_RESTART_IMPRESSORA

REM Deleta tarefa no Agendador de Tarefas
schtasks /delete /tn "CCP_RESTART_IMP" /f

REM Criação da tarefa no Agendador de Tarefas
schtasks /create /tn "CCP_RESTART_IMP" /tr "C:\AFM-3000\BAT\WIN\CCP_RESTART_IMP.bat" /sc minute /mo 2 /ru SYSTEM /RL HIGHEST /f
timeout /t 10

echo. ---------------------------------------------------------------------------------------------------------------------------------

REM CCP_MSG_IMPRESSORA

REM Deleta tarefa no Agendador de Tarefas
schtasks /delete /tn "CCP_MSG_IMP" /f

REM Criação da tarefa no Agendador de Tarefas
schtasks /create /tn "CCP_MSG_IMP" /tr "C:\AFM-3000\BAT\WIN\CCP_MSG_IMP.bat" /sc minute /mo 1 /ru SYSTEM /RL HIGHEST /f

echo. ---------------------------------------------------------------------------------------------------------------------------------

exit
