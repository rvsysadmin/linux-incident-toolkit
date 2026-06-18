#!/bin/bash

./incident-toolkit.sh > reports/report-$(date +%F-%H-%M).txt

echo "Report Generated Successfully!"
