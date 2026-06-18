#!/bin/bash

disk=$(df / | awk 'END{print $5}')

echo "Disk Usage: $disk"
