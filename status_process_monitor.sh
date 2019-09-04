#!/bin/bash

pid=`cat process.pid`

ps $pid

if [[ $? -eq 0 ]]
then
    echo -e "\e[32mProcess OK"
else
    echo -e "\e[91mProcess Not Found"
fi