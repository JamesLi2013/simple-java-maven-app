#!/bin/sh
ps -ef | grep mult_app8091.jar | grep -v grep|awk '{print $2}' |xargs -n1 kill -9