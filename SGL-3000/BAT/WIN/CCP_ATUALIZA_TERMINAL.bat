@echo off
REM Exclui todos os arquivos dentro da pasta, sem apagar a própria pasta
del /F /Q "C:\SGL-3000\BAT\*.*" >nul 2>&1

set "origem=Z:\SGL-3000\BAT"
set "destino=C:\SGL-3000\BAT"

REM Copiando arquivos...
xcopy "%origem%" "%destino%" /E /I /Y >nul 2>&1
REM Exclui servidor do Terminal
:: Excluir arquivos específicos
del /F /Q "C:\SGL-3000\BAT\AGD.BAT\CCP_AGENDADORES_SERVIDOR.bat" >nul 2>&1
del /F /Q "C:\SGL-3000\BAT\EXECUTAR\CCP_AGENDADORES_SERVIDOR.vbs" >nul 2>&1
del /F /Q "C:\SGL-3000\BAT\COPIA BAT PARA TERMINAL.BAT" >nul 2>&1
del /F /Q "C:\SGL-3000\BAT\BKP\CCP_CLOUD.bat" >nul 2>&1
del /F /Q "C:\SGL-3000\BAT\BKP\CCP_SERVIDOR.bat" >nul 2>&1

:: Excluir pastas e todo o seu conteúdo
rd /S /Q "C:\SGL-3000\BAT\EXECUTAR\FTP SERVIDOR" >nul 2>&1
rd /S /Q "C:\SGL-3000\BAT\FTP\BAT_FTP" >nul 2>&1

set "sourcePath=Z:\toolsccp"
set "destinationPath=C:\toolsccp"

REM Verifica se a pasta de destino existe, se não, cria
if not exist "%destinationPath%" mkdir "%destinationPath%" >nul 2>&1

REM Copia os arquivos com as extensões especificadas
xcopy "%sourcePath%\*.exe" "%destinationPath%" /Y >nul 2>&1
xcopy "%sourcePath%\*.dll" "%destinationPath%" /Y >nul 2>&1
xcopy "%sourcePath%\*.wdl" "%destinationPath%" /Y >nul 2>&1
xcopy "%sourcePath%\*.wdk" "%destinationPath%" /Y >nul 2>&1
xcopy "%sourcePath%\*.wdi" "%destinationPath%" /Y >nul 2>&1
xcopy "%sourcePath%\*.ico" "%destinationPath%" /Y >nul 2>&1
xcopy "%sourcePath%\*.wav" "%destinationPath%" /Y >nul 2>&1

exit
