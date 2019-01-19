#!/bin/sh
ps -ef | grep mysql | grep -v grep|awk '{print $2}' |xargs -n1 kill -9