#!/bin/bash

nohup ./process_monitor.sh >> /dev/null &

echo $! > process.pid