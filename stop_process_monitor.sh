#!/bin/bash

base_folder="/home/mjoaquim/process_monitor"

pid=`cat process.pid`

kill $pid

${base_folder}/status_process_monitor.sh