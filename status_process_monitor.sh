#!/bin/bash

base_folder="/home/mjoaquim/process_monitor"

pid=`cat ${base_folder}/process.pid`

ps $pid

if [[ $? -eq 0 ]]
then
    echo -e "\e[32mProcess STARTED"
else
    echo -e "\e[91mProcess STOPPED"
fi