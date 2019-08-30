#!/bin/bash

pid=`cat process.pid`

kill $pid

rm process.pid