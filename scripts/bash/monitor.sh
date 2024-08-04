#!/bin/bash

# Funcion para capturar el uso de la CPU y el modelo
get_cpu_usage() {
    echo "<h2>CPU Info</h2>"
    local cpu_info=$(lscpu |grep "Model name"|cut -d':' -f 2| tr -d '^ ')
    local cpu_usage=$(mpstat | grep -A 5 "%idle" | tail -n 1 | awk '{print 100 - $ 12 "%"}')
    echo "<p>Model Name: $cpu_info</p>"
    echo "<p>Uso de CPU: $cpu_usage</p>"
}

# Funcion para capturar el uso de la RAM
get_ram_usage() {
    echo "<h2>Uso de RAM</h2>"
    local ram_usage=$(free -h | awk '/^Mem/ {print "Total: "$2", Usado: "$3", Libre: "$4", Cache: "$6", Disponible: "$7}')
    echo "<p>$ram_usage</p>"
}

# Funcion para capturar el espacio en disco
get_disk_usage() {
    echo "<h2>Espacio en Disco</h2>"
    local disk_usage=$(df -h --total | grep 'total' | awk '{print "Tamaño: "$2", Usado: "$3", Disponible: "$4", Porcentaje de usado: "$5}')
    echo "<p>$disk_usage</p>"
}

# Funcion para capturar los 10 procesos que más consumen CPU
get_top_processes() {
    echo "<h2>Top 10 Procesos por Uso de CPU</h2>"
    ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 11 | tail -n 10 | while read -r pid user cpu mem comm; do
        echo "<p> PID: $pid, Usuario: $user, %CPU: $cpu, %MEM: $mem, Comando: $comm</p>"
        echo "<hr>"
    done
}

# Funcion para generar el reporte en HTML con estilos CSS
generate_html_report() {
    echo "<html>"
    echo "<head>"
    echo "<title>S_ONE Reporte de Estado del Sistema</title>"
    echo "<style>"
    echo "body { font-family: Arial, sans-serif; margin: 20px; }"
    echo "h1 { color: #333; }"
    echo "h2 { color: #0056b3; border-bottom: 1px solid #ddd; padding-bottom: 5px; }"
    echo "p { font-size: 14px; color: #333; }"
    echo ".section { margin-bottom: 20px; }"
    echo "</style>"
    echo "</head>"
    echo "<body>"
    echo "<h1>Verificación del Estado de los Recursos del Sistema</h1>"
    echo "<div class='section'>"
    get_cpu_usage
    echo "</div>"
    echo "<div class='section'>"
    get_ram_usage
    echo "</div>"
    echo "<div class='section'>"
    get_disk_usage
    echo "</div>"
    echo "<div class='section'>"
    get_top_processes
    echo "</div>"
    echo "</body>"
    echo "</html>"
}

# Guardar el reporte en un archivo HTML
output_file="linux_report.html"
generate_html_report > $output_file
echo "Reporte generado en $output_file"