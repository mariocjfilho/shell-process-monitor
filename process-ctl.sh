#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

base_folder=$DIR

pid_file=${base_folder}/process.pid

option=$1

status_process() {

    pid=`cat ${pid_file}`

    ps $pid

    if [[ $? -eq 0 ]]
    then
        echo -e "Process STARTED"
    else
        echo -e "Process STOPPED"
    fi
}

start_process() {
    echo "Starting..."
    echo ""

    nohup ${base_folder}/process_monitor.sh >> /dev/null &

    echo $! > ${base_folder}/process.pid

    status_process
    
}

check_process() {
    if [ -f "$pid_file" ]; then

        pid=`cat ${pid_file}`

        ps $pid > /dev/null

        if [[ $? -eq 0 ]]
        then
            echo -e "Process already STARTED"
            exit 0;    
        fi
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



