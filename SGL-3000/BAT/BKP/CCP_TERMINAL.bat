@echo off

:: Usa PowerShell para validar espaço disponível
powershell -NoLogo -NoProfile -Command ^
    "$min = 2147483648; $free = (Get-PSDrive C).Free; if ($free -gt $min) { exit 0 } else { exit 1 }"

:: Verifica retorno
if %ERRORLEVEL%==0 (
        echo =====================================================
        echo             CCPINFO - EFETUANDO BACKUP!
        echo          NAO FECHE OU DESLIGUE O COMPUTADOR
        echo =====================================================
    if not exist "C:\SGL-BKP\BKP" (
        mkdir "C:\SGL-BKP\BKP"
    )
    xcopy "Z:\SGL-3000" "C:\SGL-BKP\BKP" /E /I /H /Y /D >nul

    if ERRORLEVEL 1 (
	CLS
        echo =====================================================
        echo              CCPINFO - FALHA NO BACKUP!
        echo             FALTA DE ESPACO NO COMPUTADOR
        echo   SOLICITE A VISITA DE UM TECNICO PARA A MANUTENCAO
        echo                    11 3999-6000 
        echo =====================================================
start "" /min "https://ccpinformatica.movidesk.com/Account/Login"
	rmdir /S /Q "C:\SGL-BKP"
	pause
	exit
    ) else (
	CLS
        echo CCPINFO - BACKUP CONCLUIDO COM SUCESSO
    )
) else (
	CLS
        echo =====================================================
        echo              CCPINFO - FALHA NO BACKUP!
        echo             FALTA DE ESPACO NO COMPUTADOR
        echo   SOLICITE A VISITA DE UM TECNICO PARA A MANUTENCAO
        echo                    11 3999-6000 
        echo =====================================================
start "" /min "https://ccpinformatica.movidesk.com/Account/Login"
	pause
	exit

)

:: Define diretórios
set "sourceDir=C:\SGL-3000"
set "destFolder=C:\SGL-BKP\BKP"
set "shortcutPath=%USERPROFILE%\Desktop\BACKUP_SERV.lnk"

:: Criação do script VBS para gerar o atalho
echo Set objShell = CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut.vbs"
echo Set objShortcut = objShell.CreateShortcut("%shortcutPath%") >> "%TEMP%\CreateShortcut.vbs"
echo objShortcut.TargetPath = "%destFolder%" >> "%TEMP%\CreateShortcut.vbs"
echo objShortcut.WorkingDirectory = "%destFolder%" >> "%TEMP%\CreateShortcut.vbs"
echo objShortcut.IconLocation = "C:\SGL-3000\BAT\IMAGEM\ICONCCP.ico,0" >> "%TEMP%\CreateShortcut.vbs"
echo objShortcut.Save >> "%TEMP%\CreateShortcut.vbs"

:: Executa o script VBS para criar o atalho
cscript //nologo "%TEMP%\CreateShortcut.vbs"

:: Remove o script VBS temporário
del "%TEMP%\CreateShortcut.vbs"

endlocal
exit