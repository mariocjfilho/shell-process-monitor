#!/bin/bash

base_folder="/home/mjoaquim/process_monitor"

pid_file=${base_folder}/process.pid

start_process() {
    echo "Starting..."
    echo ""

    nohup ${base_folder}/process_monitor.sh >> /dev/null &

    echo $! > ${base_folder}/process.pid

    ${base_folder}/status_process_monitor.sh
}

if [ -f "$pid_file" ]; then

    pid=`cat ${pid_file}`

    ps $pid > /dev/null

    if [[ $? -eq 0 ]]
    then
        echo -e "\e[32mProcess already STARTED"
        exit 0;    
    fi
fi

start_process

