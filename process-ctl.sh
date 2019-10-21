#!/bin/bash

base_folder="/home/mjoaquim/process_monitor"

pid_file=${base_folder}/process.pid

option=$1

start_process() {
    echo "Starting..."
    echo ""

    nohup ${base_folder}/process_monitor.sh >> /dev/null &

    echo $! > ${base_folder}/process.pid

    ${base_folder}/status_process_monitor.sh
}

check_process() {
    if [ -f "$pid_file" ]; then

        pid=`cat ${pid_file}`

        ps $pid > /dev/null

        if [[ $? -eq 0 ]]
        then
            echo -e "\e[32mProcess already STARTED"
            exit 0;    
        fi
    fi
}

status_process() {

    pid=`cat ${pid_file}`

    ps $pid

    if [[ $? -eq 0 ]]
    then
        echo -e "\e[32mProcess STARTED"
    else
        echo -e "\e[91mProcess STOPPED"
    fi
}

stop_process() {

    pid=`cat ${pid_file}`

    kill $pid
}

case $option in
    start)
        check_process
        start_process
        ;;
    stop)
        stop_process
        status_process
        ;;
    status)
        status_process
        ;;

    *)
        echo "Invalid option"
        echo "Options available: start | stop | status "
        ;;
esac



