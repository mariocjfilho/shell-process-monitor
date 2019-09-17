#!/bin/bash

# Executando o script em background - nohup ./process_monitor.sh >> /dev/null &

# Variáveis
MAX_PCPU=150
MAX_PMEM=15
MAX_LOAD=8
MAX_CPU_TEMPERATURE=75

base_log_folder="/home/mjoaquim/process_monitor/logs"

main() {

    mkdir -p $base_log_folder

    while [ true ]
    do
        cpu_log_file="${base_log_folder}/cpu_log_$(date -I).log"
        mem_log_file="${base_log_folder}/mem_log_$(date -I).log"
        load_log_file="${base_log_folder}/load_log_$(date -I).log"
        cpu_temp_log_file="${base_log_folder}/cpu_temp_log_$(date -I).log"

        cpu_monitor
        mem_monitor
        load_monitor
        cpu_temperature_monitor

        sleep 2

    done
}

cpu_monitor() {

    pcpu=`ps -eo pcpu --sort=-pcpu | head -n 2 | tail -1 | cut -d "." -f 1`
    p_info_cpu=`ps aux --sort=-pcpu | head -n 2 | tail -1`

    echo "PCPU: $pcpu"

    if [[ $pcpu -ge $MAX_PCPU ]]
    then
        echo "Processo atingiu o máximo de uso de CPU"
        echo "PCPU: $pcpu"
        echo "Process Info: $p_info_cpu"

        echo "" >> $cpu_log_file
        echo "[$(date)] - Processo atingiu o máximo de uso de CPU" >> $cpu_log_file
        echo "[$(date)] - PCPU: $pcpu" >> $cpu_log_file
        echo "[$(date)] - Process Info: $p_info_cpu" >> $cpu_log_file
    fi
}


mem_monitor() {

    pmem=`ps -eo pmem --sort=-pmem | head -n 2 | tail -1 | cut -d "." -f 1`
    p_info_mem=`ps aux --sort=-pmem | head -n 2 | tail -1`

    echo "PMEM: $pmem"

    if [[ $pmem -ge $MAX_PMEM ]]
    then
        echo "Processo atingiu o máximo de uso de Memória"
        echo "PMEM: $pmem"

        echo "" >> $mem_log_file
        echo "[$(date)] - Processo atingiu o máximo de uso de Memória" >> $mem_log_file
        echo "[$(date)] - PMEM: $pmem" >> $mem_log_file
        echo "[$(date)] - Process Info: $p_info_mem" >> $mem_log_file
    fi
}

load_monitor() {

    load=`uptime | cut -d "," -f 3,4 | cut -d ":" -f 2`
    round_load=`echo "(${load/,/.}+0.5)/1" | bc`

    echo "Load: $load"

    if [[ $round_load -ge $MAX_LOAD ]]
    then
        echo "Load Máximo atingido"
        echo "Load: $load"

        echo "" >> $load_log_file
        echo "[$(date)] - Load Máximo atingido..." >> $load_log_file
        echo "[$(date)] - Load: $load" >> $load_log_file
        
        echo "[$(date)] - 5 processos que mais consumiram memória: " >> $load_log_file
        echo "" >> $load_log_file
        ps aux --sort=-pmem | head -n 5 >> $load_log_file

        echo "[$(date)] - 5 processos que mais consumiram CPU: " >> $load_log_file
        echo "" >> $load_log_file
        
        ps aux --sort=-pcpu | head -n 5 >> $load_log_file

    fi

}

cpu_temperature_monitor() {

    # TODO - Check if this is default for all computers

    cpu_temp=`sensors -u coretemp-isa-0000 | grep -i "temp1_input" | head -1 | cut -d ":" -f 2 | cut -d "." -f 1`

    echo "CPU Temp: $cpu_temp"

    if [[ $cpu_temp -ge $MAX_CPU_TEMPERATURE ]]
    then
        echo "Temperatura limite atingida"
        echo "CPU Temp: $cpu_temp"

        echo "" >> $cpu_temp_log_file
        echo "[$(date)] - Temperatura limite atingida..." >> $cpu_temp_log_file
        echo "[$(date)] - CPU Temp: $cpu_temp" >> $cpu_temp_log_file
        
        echo "[$(date)] - 5 processos que mais consumiram memória: " >> $cpu_temp_log_file
        echo "" >> $cpu_temp_log_file
        ps aux --sort=-pmem | head -n 5 >> $cpu_temp_log_file

        echo "[$(date)] - 5 processos que mais consumiram CPU: " >> $cpu_temp_log_file
        echo "" >> $cpu_temp_log_file
        ps aux --sort=-pcpu | head -n 5 >> $cpu_temp_log_file
    fi

}

main


