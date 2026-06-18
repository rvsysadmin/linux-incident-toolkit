#!/bin/bash

echo "Top 5 CPU Processes:"
ps aux --sort=-%cpu | head -6
