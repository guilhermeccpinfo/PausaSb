@echo off

REM Exclui log
del /F /Q "C:\SGL-3000\FTP0001.LOG" "C:\SGL-3000\FTP0002.LOG" "C:\SGL-3000\FTP0010.LOG" "C:\SGL-3000\FTP0011.LOG"

REM Limpa REC e RPS
rmdir /s /q C:\SGL-3000\REC
rmdir /s /q C:\SGL-3000\TRF
mkdir C:\SGL-3000\REC
mkdir C:\SGL-3000\TRF

cls
echo [34m====================================================[[36mCCP[0m[33minfo[0m[34m]=[0m
echo ENVIA ARQUIVOS DA [32;5mMATRIZ[0m ^> [96;5mFILIAL[0m
echo ENCERRANDO PROGRAMAS EM SEGUNDO PLANO

REM [INFORMAÇÕES SOBRE QUAL .EXE UTILIZAR]
REM ftp0010 > EXECUTA na MATRIZ e ENVIA para a FILIAL
REM ftp0011 > EXECUTA na MATRIZ e RECEBE dados da FILIAL

REM Encerrar programas [Remova :: para ATIVAR o comando necessário]
echo [91m
tskill ftp0011 /A
tskill ftp0010 /A
echo [0m

REM Encerramentos OBRIGATÓRIOS NÃO ALTERAR!!!
echo [41m
tskill ftp64 /A
tskill ftp32 /A
tskill winrar.exe /A
echo [0m
                            
REM **IMPORTANTE** Indicar o caminho correto de onde estão os .EXE do FTP [C:\SGL-3000\ ou C:\SGL-3000\]
echo ACESSANDO A PASTA DO [92;1mC:\SGL-3000\[0m 
cd\
cd SGL-3000

echo [45mWin[0m[42mRAR[0m ^> COMPACTANDO ARQUIVOS
echo [93;5mAGUARDE A FINALIZACAO DO PROCESSO[0m
echo [34m===============================================[[33m11-3999.6000[0m[34m]=[0m

REM Executa programas [Remova :: para ATIVAR o comando necessário]
ftp0011.exe
ftp0010.exe

echo TRANSFERENCIA DE ARQUIVOS FINALIZADA
echo [34m==============================================================[0m
exit