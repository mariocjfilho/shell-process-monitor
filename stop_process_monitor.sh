#!/bin/bash

base_folder="/home/mjoaquim/process_monitor"

pid=`cat ${base_folder}/process.pid`

kill $pid

${base_folder}/status_process_monitor.sh