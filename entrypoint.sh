#!/bin/bash

#ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

goesproc --config=/usr/local/share/goestools/goesproc-goesr.conf -m packet --subscribe tcp://${IP_GOESRECV}:5004
