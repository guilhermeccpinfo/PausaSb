@echo off

setlocal

REM CRIAR PASTA CCP LIXEIRA 
set "targetDir=C:\CCP LIXEIRA"

:: Verifica se a pasta já existe
if not exist "%targetDir%" mkdir "%targetDir%"

REM -------------------------------------------------------------------------------------------------------

REM EXCLUIR POR DEFINITIVO ARQUIVOS MOVIDOS PARA A PASTA CCP LIXEIRA 
set "targetDir=C:\CCP LIXEIRA"
set "dias=30"

:: MOVER arquivos com mais de 30 dias
forfiles /p "%targetDir%" /s /m * /d -%dias% /c "cmd /c del /F /Q @file >nul 2>&1"

echo. -------------------------------------------------------------------------------------------------------

echo. Excluindo Arquivos da Lixeira...
if exist C:\$Recycle.Bin rd /s /q C:\$Recycle.Bin >nul 2>&1

echo. Excluindo arquivos temporários...
if exist "%temp%" (
    del /s /q "%temp%\*" >nul 2>&1
    rd /s /q "%temp%" >nul 2>&1
)

echo. Limpando Arquivos do Windows Update...
if exist C:\Windows\SoftwareDistribution\Download (
    rd /s /q C:\Windows\SoftwareDistribution\Download
)

echo. Limpando Arquivos de Otimização de Entrega...
if exist C:\Windows\DeliveryOptimization (
    rd /s /q C:\Windows\DeliveryOptimization
)

echo. Excluindo arquivos da pasta Downloads com mais de 30 dias...
if exist "C:\Users\%username%\Downloads" (
    forfiles /p "C:\Users\%username%\Downloads" /s /m *.* /d -30 /c "cmd /c del /q @file"
)

echo. Exclui arquivos C:\TEMPOR...
rd /s /q "C:\TEMPOR"
mkdir "C:\TEMPOR"
)

echo. Exclui arquivos Log AFM com mais de 30 dias...
forfiles /P "C:\AFM-3000" /S /M *.LOG /D -30 /C "cmd /c del /F /Q @file"
)

echo. -------------------------------------------------------------------------------------------------------

REM MOVER AFM-3000\BACKUP
setlocal

:: Define o diretório alvo
set "targetDir=C:\AFM-3000\BACKUP"

:: MOVER arquivos com mais de 7 dias
forfiles /p "%targetDir%" /s /m *.* /d -7 /c "cmd /c del @file"
