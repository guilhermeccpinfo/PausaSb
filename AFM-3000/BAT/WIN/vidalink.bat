@echo off
set /p loja="Digite o numero da loja (01-99): "
echo Z%loja% > C:\vidalink.ini
echo Arquivo vidalink.ini criado em C: com sucesso!
if exist C:\vidalink.ini (
    notepad C:\vidalink.ini
) else (
    echo O arquivo vidalink.ini não existe!
)
exit