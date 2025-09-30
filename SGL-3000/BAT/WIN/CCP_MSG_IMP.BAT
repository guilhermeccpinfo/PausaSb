@echo off

:: Define a pasta de spool
set "SpoolFolder=%systemroot%\System32\spool\PRINTERS"

:: Conta os arquivos na pasta de spool
for /f %%A in ('dir /b "%SpoolFolder%" ^| find /c /v ""') do set "FileCount=%%A"

:: Verifica se há mais de 3 documentos na fila
if %FileCount% GTR 5 (
msg * "URGENTE!.. VERIFIQUE A IMPRESSORA!.. TENTE REINICIAR OU TROCAR A PORTA USB!.."

)
