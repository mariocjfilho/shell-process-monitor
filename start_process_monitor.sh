#!/bin/bash

base_folder="/home/mjoaquim/process_monitor"

nohup ${base_folder}/process_monitor.sh >> /dev/null &

echo $! > ${base_folder}/process.pid

${base_folder}/status_process_monitor.sh