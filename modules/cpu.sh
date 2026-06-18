#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100-$8}')

echo "CPU Usage: $cpu_usage%"
