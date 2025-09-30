@echo off
C:

REM Finaliza processos indesejados
taskkill /f /im winrar.exe
taskkill /f /im gerencia.exe
taskkill /f /im boca.exe
taskkill /f /im backupSKY.exe
taskkill /f /im ccpSky.exe

REM Navega até a pasta correta e executa o gerenciador
CD\SGL-3000
start "" /b gerencia.exe

REM Encerra o script
exit
