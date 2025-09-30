@echo off

REM Exclui Criador de Atalhos duplicados
set "startup_path=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "current_file=%~nx0"

for %%F in ("%startup_path%\*Win*.bat" "%startup_path%\*Suporte*.bat") do (
    if /I not "%%~nxF"=="%current_file%" (
        del /F /Q "%%F"
    )
)


REM Caminho do script original
set "script_path=%~dpnx0"

REM Caminho para a pasta de inicialização
set "startup_folder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

REM Copiar o script para a pasta de inicialização
copy "%script_path%" "%startup_folder%" >nul

REM Criar Pasta com Atalhos de Suporte
mkdir "%USERPROFILE%\Desktop\CCP SUPORTE"
echo [.ShellClassInfo] > "%USERPROFILE%\Desktop\CCP SUPORTE\desktop.ini"
echo IconResource=C:\AFM-3000\BAT\IMAGEM\ICONCCP.ico,0 >> "%USERPROFILE%\Desktop\CCP SUPORTE\desktop.ini"
attrib +S +H "%USERPROFILE%\Desktop\CCP SUPORTE\desktop.ini"
attrib +S "%USERPROFILE%\Desktop\CCP SUPORTE"

echo CRIANDO ATALHO CHAT
echo [InternetShortcut] > "%userprofile%\Desktop\CCP SUPORTE\CHAT SUPORTE.url"
echo URL=https://ccpinformatica.movidesk.com/Account/Login >> "%userprofile%\Desktop\CCP SUPORTE\CHAT SUPORTE.url"
echo IconFile=C:\AFM-3000\BAT\IMAGEM\ICONCCP.ico >> "%userprofile%\Desktop\CCP SUPORTE\CHAT SUPORTE.url"
echo IconIndex=0 >> "%userprofile%\Desktop\CCP SUPORTE\CHAT SUPORTE.url"

echo CRIANDO ATALHO CHAT
echo [InternetShortcut] > "%userprofile%\Desktop\CHAT SUPORTE.url"
echo URL=https://ccpinformatica.movidesk.com/Account/Login >> "%userprofile%\Desktop\CHAT SUPORTE.url"
echo IconFile=C:\AFM-3000\BAT\IMAGEM\ICONCCP.ico >> "%userprofile%\Desktop\CHAT SUPORTE.url"
echo IconIndex=0 >> "%userprofile%\Desktop\CHAT SUPORTE.url"

echo CRIANDO ATALHO BASE CONHECIMENTO
echo [InternetShortcut] > "%userprofile%\Desktop\CCP SUPORTE\BASE CONHECIMENTO.url"
echo URL=https://ccpinfo.com.br/basedeconhecimento.html >> "%userprofile%\Desktop\CCP SUPORTE\BASE CONHECIMENTO.url"
echo IconFile=C:\AFM-3000\BAT\IMAGEM\ICONCCP.ico >> "%userprofile%\Desktop\CCP SUPORTE\BASE CONHECIMENTO.url"
echo IconIndex=0 >> "%userprofile%\Desktop\CCP SUPORTE\BASE CONHECIMENTO.url"

echo CRIA ATALHO YOUTUBE
echo [InternetShortcut] > "%userprofile%\Desktop\CCP SUPORTE\YOUTUBE CCPinfo.url"
echo URL=https://www.youtube.com/@ccpinfooficial >> "%userprofile%\Desktop\CCP SUPORTE\YOUTUBE CCPinfo.url"
echo IconFile=C:\AFM-3000\BAT\IMAGEM\ICONCCP.ico >> "%userprofile%\Desktop\CCP SUPORTE\YOUTUBE CCPinfo.url"
echo IconIndex=0 >> "%userprofile%\Desktop\CCP SUPORTE\YOUTUBE CCPinfo.url"

echo CRIANDO ACESSO REMOTO
xcopy "C:\AFM-3000\BAT\Acesso Remoto Win 64x\Acesso Remoto CCPinfo Support.exe" "%USERPROFILE%\Desktop\" /H /Y /C /Q > nul 2>&1
xcopy "C:\AFM-3000\BAT\Acesso Remoto Win 64x\Acesso Remoto CCPinfo Support.exe" "%USERPROFILE%\Desktop\CCP SUPORTE" /H /Y /C /Q > nul 2>&1
exit