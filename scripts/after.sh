#!/bin/sh
HOST=`hostname`
cd /data/pipeline && echo "hostname: $HOST" >> hostname
