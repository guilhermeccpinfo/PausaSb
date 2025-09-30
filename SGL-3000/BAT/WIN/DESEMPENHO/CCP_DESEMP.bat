@echo off
REM Configurar o tamanho da janela CMD
mode con: cols=160 lines=40

------------------------------------------------------------------------------------------------------------------------

cls
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo =======================================================
    echo FALHA NOS PRIVILEGIOS - EXECUTE COMO ADMINISTRADOR!
    echo =======================================================
    pause
    exit /b
)

------------------------------------------------------------------------------------------------------------------------

cls
echo Politica PowerShell 'Unrestricted'.
powershell -Command "Set-ExecutionPolicy Unrestricted -Force"

------------------------------------------------------------------------------------------------------------------------

cls
echo Windows Defender
start /min "" "C:\SGL-3000\BAT\WIN\Windows Defender.bat"

------------------------------------------------------------------------------------------------------------------------

cls
echo EXECUTA POWERSHELL ADM AGUARDE...
timeout /t 2 /nobreak >nul
echo.
echo Executa PowerShell ADM Adicionais
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""C:\SGL-3000\BAT\WIN\DESEMPENHO\Adicionais.ps1""' -Verb RunAs}"

------------------------------------------------------------------------------------------------------------------------

cls
echo PARAMETRIZANDO DESEMPENHO WINDOWS AGUARDE...
timeout /t 2 /nobreak >nul
echo.
echo Opcoes de Energia para Alto Desempenho
powercfg -setactive SCHEME_MIN

echo Tela Desligar e Suspensao Nunca
powercfg -change -monitor-timeout-ac 0
powercfg -change -monitor-timeout-dc 0
powercfg -change -standby-timeout-ac 0
powercfg -change -standby-timeout-dc 0

echo Disco Rigido Nunca Desligar
powercfg -change -disk-timeout-ac 0
powercfg -change -disk-timeout-dc 0

echo Desabilitando Inicializacao Rapida
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f

echo Pesquisa Icone
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f

echo Oculta Cortana
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCortanaButton" /t REG_DWORD /d 0 /f

echo Oculta Visao de Tarefas
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f

echo Configurando Firewall do Windows Defender
netsh advfirewall set privateprofile state off
netsh advfirewall set publicprofile state off
netsh advfirewall set domainprofile state off

echo Desabilita UAC
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f

echo Efeitos Visuais Melhor Desempenho
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations" /v EnableAnimations /t REG_DWORD /d 0 /f

echo Habilita Extensão de Arquivos
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f

echo Reiniciar o Explorer para aplicar as alteracões
taskkill /f /im explorer.exe
start explorer.exe

------------------------------------------------------------------------------------------------------------------------

cls
echo PARAMETRIZANDO COMPARTILHAMENTO DE REDE AGUARDE...
timeout /t 2 /nobreak >nul
echo.
echo Correcao Impressora de Rede Compartilhada
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Print" /v "RpcAuthnLevelPrivacyEnabled" /t REG_DWORD /d 0 /f

echo Configurando Compartilhamento de Rede...
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=yes
netsh advfirewall firewall set rule group="Network Discovery" new enable=yes
netsh advfirewall firewall set rule group="Descoberta de Rede" new enable=yes
netsh advfirewall firewall set rule group="Compartilhamento de Arquivos e Impressoras" new enable=yes
netsh advfirewall firewall set rule group="Compartilhamento de Arquivos e Impressoras" new enable=Yes
icacls "%PUBLIC%" /grant "Todos":(F) /T /C
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v everyoneincludesanonymous /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v NoLmHash /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v restrictnullsessaccess /t REG_DWORD /d 0 /f

echo Desabilita Sincronizacao arquivos offline
sc config CscService start= disabled
net stop CscService
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\NetCache" /v Enabled /t REG_DWORD /d 0 /f

echo Ajusta Compartilhamento de Rede
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v RequireSecuritySignature /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v RequireSecuritySignature /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v AllowInsecureGuestAuth /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v RestrictAnonymous /t REG_DWORD /d 0 /f


------------------------------------------------------------------------------------------------------------------------

cls
echo LIMPEZA DE ARQUIVOS AGUARDE...
timeout /t 2 /nobreak >nul
echo.
echo Excluindo Arquivos Lixeira
del /s /q C:\$Recycle.Bin >nul 2>&1
rd /s /q C:\$Recycle.Bin >nul 2>&1

echo Exclui arquivos Temporarios...
del /s /q "%temp%\*" >nul 2>&1
rd /s /q "%temp%" >nul 2>&1

echo Exclui arquivos C:\TEMPOR...
rd /s /q "C:\TEMPOR"
mkdir "C:\TEMPOR"

echo Limpando Arquivos do Windows Update...
rd /s /q C:\Windows\SoftwareDistribution\Download >nul 2>&1

echo Limpando Arquivos de Otimização de Entrega...
rd /s /q C:\Windows\DeliveryOptimization >nul 2>&1

echo Excluindo arquivos da pasta Downloads com mais de 30 dias...
forfiles /p C:\Users\%username%\Downloads /s /m *.* /d -30 /c "cmd /c del /q @file" >nul 2>&1

echo Reiniciar o Explorer para aplicar as alteracões
taskkill /f /im explorer.exe
start explorer.exe
