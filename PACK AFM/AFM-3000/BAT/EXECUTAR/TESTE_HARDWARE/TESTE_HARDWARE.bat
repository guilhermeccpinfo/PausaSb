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
echo ==========================================================================
echo     ATENCAO SUPORTE PRINTAR AS INFORMACOES E DOCUMENTAR NO CHAMADO
echo ==========================================================================
echo                 VERIFICANDO REQUISITOS MINIMOS DE HARDWARE                 
echo ==========================================================================
echo ====================== VERIFICANDO ATIVACAO WINDOWS ======================
:: Obtem a chave de ativacao original (caso exista)
for /f "tokens=2 delims==" %%A in ('wmic path SoftwareLicensingService get OA3xOriginalProductKey /value') do set "chaveOriginal=%%A"
:: Obtem o status de ativacao do Windows
for /f "tokens=2 delims==" %%B in ('wmic path SoftwareLicensingProduct where "LicenseStatus>0" get LicenseStatus /value') do set "status=%%B"
:: Verifica o status da ativacao
if "%status%"=="1" (
    set "resultado= REPROVADO - WINDOWS CRAQUEADO LICENCA OEM."
) else if "%status%"=="2" (
    set "resultado= REPROVADO - WINDOWS CRAQUEADO VIA KMS OU MAK."
) else if "%status%"=="3" (
    set "resultado= REPROVADO - WINDOWS CRAQUEADO **LICENCA KMS OU MAK**."
) else (
    set "resultado= APROVADO - WINDOWS VERSAO **TRIAL (GRAUITA) OU SEM ATIVACAO**."
)                      
echo %resultado%
:: Exibe a chave do Windows (se disponivel)
if not "%chaveOriginal%"=="" echo Chave Original: %chaveOriginal%
echo.
echo ========================= NOME DO COMPUTADOR ===========================
wmic  computersystem get Name | findstr /r /v "^Name"
echo ============================= PROCESSADOR ==============================
wmic  cpu get Name | findstr /r /v "^Name"
echo ============================= MEMORIA RAM ==============================
wmic  OS get TotalVisibleMemorySize, FreePhysicalMemory
echo ======================== ARMAZENAMENTO DO DISCO ========================
wmic  diskdrive get Model, Size, SerialNumber
wmic  logicaldisk get Caption, FileSystem, FreeSpace, Size
echo ========================== PLACA DE REDE ===============================
wmic  NIC where "NetEnabled='true'" get Name, Speed, MACAddress
echo ========================================================================
echo                        VERIFICACAO CONCLUIDA       
echo ========================================================================
echo.
echo ATENDE OS REQUISITOS MINIMOS?
echo PRESSIONE [S] PARA CONTINUAR OU [N] PARA SAIR

choice /C SN /N /M "ESCOLHA UMA OPCAO: "

if %errorlevel% EQU 2 (
    echo OPERACAO CANCELADA...
    exit /b
) else (
    echo INICIANDO...
    rem Adicione aqui os comandos que devem ser executados ao continuar
)

------------------------------------------------------------------------------------------------------------------------

cls
echo Política PowerShell 'Unrestricted'.
powershell -Command "Set-ExecutionPolicy Unrestricted -Force"

------------------------------------------------------------------------------------------------------------------------

cls
echo EXECUTANDO TESTES WINDOWS...
echo Executa PowerShell ADM InfoHardware.ps1
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""C:\AFM-3000\BAT\EXECUTAR\TESTE_HARDWARE\TESTE_HARDWARE.ps1""' -Verb RunAs}"

