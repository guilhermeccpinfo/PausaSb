@echo off
REM VERSAO WINDOWS
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    echo Windows 32 bits detectado.
    call "c:\AFM-3000\BAT\WIN\_Cria Atalho Suporte Win 32x.bat"
) else (
    echo Windows 64 bits detectado.
    call "c:\AFM-3000\BAT\WIN\_Cria Atalho Suporte Win 64x.BAT"
)

echo Processo concluído!
pause