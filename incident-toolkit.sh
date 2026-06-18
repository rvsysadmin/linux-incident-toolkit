#!/bin/bash

echo "=============================="
echo "  INCIDENT RESPONSE REPORT"
echo "=============================="

echo ""

bash modules/cpu.sh
bash modules/memory.sh
bash modules/disk.sh
bash modules/process.sh
bash modules/security.sh

echo ""
echo "=============================="
echo "Report Generated Successfully"
echo "=============================="
