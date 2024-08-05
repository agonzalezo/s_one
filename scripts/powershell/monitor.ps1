## Capturar informacion de cpu y memoria
$CPU_USSAGE=(Get-WmiObject -Class Win32_Processor).LoadPercentage
$TOTAL_MEMORY = ((Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory / 1GB)
$FREE_MEMORY = ((Get-WmiObject -Class Win32_OperatingSystem).FreePhysicalMemory / 1KB) 

# Obtener informacion de disco
$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$freeSpaceGB = [math]::round($disk.FreeSpace / 1GB, 2)

# Obtener tiempo de actividad
$uptime = (Get-WmiObject Win32_OperatingSystem).LastBootUpTime

# Crear un objeto recopilando las metricas obtenidas
$data = [PSCustomObject]@{
    "Uso de CPU (%)"           = $CPU_USSAGE
    "Memoria Total (GB)"       = $TOTAL_MEMORY
    "Memoria Libre (GB)"       = $FREE_MEMORY
    "Boot Time"      = $uptime.ToString()
}

# Convertir a HTML y remplazar los valores por las variables
$htmlContent = @"
<html>
<head>
    <title>Informe del sistema</title>
    <style>
        table, th, td { border: 1px solid black; border-collapse: collapse; }
        th, td { padding: 5px; text-align: left; }
    </style>
</head>
<body>
    <h1>Informe del sistema</h1>
    <h2>Informe general</h2>
    <table>
        <tr><th>Componente</th><th>Valor</th></tr>
        <tr><td>Uso de CPU (%)</td><td>$($data.'Uso de CPU (%)')</td></tr>
        <tr><td>Memoria Total (GB)</td><td>$($data.'Memoria Total (GB)')</td></tr>
        <tr><td>Memoria Libre (GB)</td><td>$($data.'Memoria Libre (GB)')</td></tr>
        <tr><td>Boot Time</td><td>$($data.'Boot Time')</td></tr>
    </table>
    <h2>Informe de discos</h2>
    <table>
        <tr><th>Nombre</th><th>Espacio Total (GB)</th><th>Espacio Libre (GB)</th></tr>
        <tr><td>$($disk.DeviceID)</td><td>$($disk.Size / 1GB)</td><td>$($freeSpaceGB)</td></tr>
    </table>
</body>
</html>
"@

# Guardar el contenido HTML en un archivo
$htmlContent | Out-File -FilePath "Windows_report.html"

Write-Output "Reporte generado en .\Windows_report.html"
