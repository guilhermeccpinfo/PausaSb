# Ativa ByPass PowerShell
PowerShell -NoProfile -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Force"

# Desativar compartilhamento protegido por senha
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "LimitBlankPasswordUse" -Value 0

#Ativa Historico de Transferencia Win+V
reg add "HKEY_CURRENT_USER\Software\Microsoft\Clipboard" /v EnableClipboardHistory /t REG_DWORD /d 1 /f

# Habilitar o Sensor de Armazenamento
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 1 /f

# Configurar a exclusão de arquivos da Lixeira com mais de 30 dias
Set-ItemProperty -Path $regPath -Name "02" -Value 30

# Configurar a exclusão de arquivos da Donwload com mais de 30 dias
Set-ItemProperty -Path $regPath -Name "03" -Value 30

# Desliga Noticias e Interesses
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2