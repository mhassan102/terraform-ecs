#!/bin/sh
cd /home/testing
timeout 10 python /home/testing/testcron.py >>/var/log/crontesting.log 2>&1
