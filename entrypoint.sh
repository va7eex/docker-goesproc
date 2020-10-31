#!/bin/bash

#ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ping -c 10 $IP_GOESRECV \
&& goesproc --config=/usr/local/share/goestools/goesproc-goesr.conf -m packet --subscribe tcp://${IP_GOESRECV}:5004 \
|| echo "Failed to connect to ${IP_GOESRECV}"
