#!/bin/bash

memory=$(free | awk '/Mem/{printf("%.2f"), $3/$2 *100}')

echo "Memory Usage: $memory%"
