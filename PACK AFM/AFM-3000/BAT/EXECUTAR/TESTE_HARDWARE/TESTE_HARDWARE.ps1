Write-Host "========================================================================"
Write-Host "          EQUIPE DE SUPORTE PRINTAR INFORMACOES ABAIXO NO CHAMADO       "
Write-Host "                         PALAVRA CHAVE = BRASIL                         "
Write-Host "========================================================================"
Write-Host "                      VERIFICANDO ATIVA��O WINDOWS                      " 
Write-Host "========================================================================"
Write-Host

# Obter a chave de ativa��o original (se dispon�vel)
$chaveOriginal = (Get-CimInstance -Query "Select OA3xOriginalProductKey from SoftwareLicensingService").OA3xOriginalProductKey

# Obter o status de ativa��o do Windows
$status = (Get-CimInstance -Query "Select LicenseStatus from SoftwareLicensingProduct where LicenseStatus > 0").LicenseStatus

# Verificar o status da ativa��o
if ($status -eq 1) {
    $resultado = "  RESULTADO: REPROVADO - WINDOWS ATIVADO CORRETAMENTE (OEM ORIGINAL)."
} elseif ($status -eq 2) {
    $resultado = "  RESULTADO: REPROVADO - WINDOWS ATIVADO, MAS PODE SER KMS OU MAK (CRAQUEADO)."
} elseif ($status -eq 3) {
    $resultado = "  RESULTADO: REPROVADO - WINDOWS CRAQUEADO! (COMPROMETE ARQUIVOS DO SISTEMA)."
} else {
    $resultado = "  RESULTADO: APROVADO - WINDOWS TRIAL VERS�O SEM ATIVA��O (GRATUITO)."
}

# Exibir o resultado
Write-Host $resultado

# Obter informa��es detalhadas do computador
Write-Host
Write-Host "======================= INFORMA��ES DO COMPUTADOR ======================="
Write-Host
# Nome do computador
$computerName = (Get-CimInstance Win32_ComputerSystem).Name
Write-Host "  Nome do Computador: $computerName"
Write-Host
# Processador
Write-Host "============================== PROCESSADOR =============================="
Write-Host
$processor = Get-CimInstance Win32_Processor
Write-Host "  Processador: $($processor.Name)"
Write-Host
# Mem�ria RAM total instalada
Write-Host "=============================== MEMORIA RAM ============================="
Write-Host
$totalRAM = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB
$usedRAM = $totalRAM - ((Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB)
Write-Host ("  Mem�ria RAM Total: {0} GB" -f [math]::Round($totalRAM, 2))
Write-Host ("  Mem�ria RAM Utilizada: {0} GB" -f [math]::Round($usedRAM, 2))

$memoryChips = Get-CimInstance Win32_PhysicalMemory
foreach ($chip in $memoryChips) {
    switch ($chip.MemoryType) {
        20 { Write-Host "  Modelo: DDR2" }
        21 { Write-Host "  Modelo: DDR2 FB-DIMM" }
        24 { Write-Host "  Modelo: DDR3" }
        26 { Write-Host "  Modelo: DDR4" }
        Default { Write-Host "  Modelo: Desconhecido" }
    }
}
Write-Host
# Informa��es de HDs conectados
Write-Host "============================== HD(s) ===================================="
Write-Host
$drives = Get-CimInstance Win32_DiskDrive
$logicalDisks = Get-CimInstance Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 }
foreach ($drive in $drives) {
    Write-Host "  Modelo: $($drive.Model)"
    Write-Host "  N�mero de S�rie: $($drive.SerialNumber)"
    Write-Host "------------------------------------------------------------"
}
foreach ($disk in $logicalDisks) {
    Write-Host "  Unidade: $($disk.DeviceID)"
    Write-Host "  Espa�o Total: $([math]::Round($disk.Size / 1GB, 2)) GB"
    Write-Host "  Espa�o Livre: $([math]::Round($disk.FreeSpace / 1GB, 2)) GB"
}
Write-Host
# Informa��es da placa de rede
Write-Host "============================= PLACA DE REDE =============================="
Write-Host
$networkAdapters = Get-CimInstance Win32_NetworkAdapter | Where-Object { $_.NetEnabled -eq $true }

foreach ($adapter in $networkAdapters) {
    if ($adapter.NetConnectionID -eq "Wi-Fi" -or $adapter.Name -match "Wi-Fi|Wireless") {
        Write-Host "  Tipo de Conex�o: Wi-Fi"
    } elseif ($adapter.AdapterType -eq "Ethernet 802.3") {
        Write-Host "  Tipo de Conex�o: Cabeada (Ethernet)"
    } else {
        Write-Host "  Tipo de Conex�o: Desconhecido"
    }
    if ($adapter.Speed -ne $null) {
        $speedMbps = $adapter.Speed / 1MB
        $speedGbps = $speedMbps / 1000
        Write-Host ("  Velocidade: {0} Mbps ({1} Gbps)" -f [math]::Round($speedMbps, 2), [math]::Round($speedGbps, 2))
    } else {
        Write-Host "  Velocidade: Informa��o n�o dispon�vel"
    }
    Write-Host "  Modelo: $($adapter.Name)"
    Write-Host "  Tipo: $($adapter.AdapterType)"
    Write-Host "  Endere�o MAC: $($adapter.MACAddress)"
    Write-Host
}
Write-Host "=========================================================================="
Start-Process "ms-screenclip:"
Write-Host "A ferramenta de captura foi aberta. Realize o recorte e salve manualmente."
do {
    Write-Host
    Write-Host "AP�S PRINTAR E DOCUMENTAR NO CHAMADO, DIGITE A PALAVRA-CHAVE PARA CONTINUAR: "
    $entrada = Read-Host "Digite a palavra-chave"

    if ($entrada -eq "BRASIL") {
        Write-Host "PALAVRA-CHAVE CORRETA."
        Start-Sleep -Seconds 2
        exit
    } else {
        Write-Host
        Write-Host "PALAVRA-CHAVE INCORRETA!"
        Write-Host
    }
} while ($true)
