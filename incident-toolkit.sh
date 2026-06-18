#!/bin/bash

mkdir -p reports logs

TIMESTAMP=$(date +%F-%H-%M)
REPORT="reports/report-$TIMESTAMP.json"
LOG="logs/system-$TIMESTAMP.log"

echo "Collecting system metrics..."

CPU=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')
MEM=$(free | awk '/Mem/ {printf "%.0f", $3/$2 * 100}')
DISK=$(df / | awk 'END{print $5}' | tr -d '%')
FAILED_SSH=$(grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l)

# SAFE DEFAULT VALUES (IMPORTANT FIX)
# SAFE DEFAULT VALUES
CPU=${CPU:-0}
MEM=${MEM:-0}
DISK=${DISK:-0}

# convert float to integer safely
CPU_INT=${CPU%.*}
MEM_INT=${MEM%.*}

# thresholds
CPU_ALERT=85
MEM_ALERT=85
DISK_ALERT=85

STATUS="OK"

if [ "$CPU_INT" -gt "$CPU_ALERT" ]; then
    STATUS="CRITICAL"
fi

if [ "$MEM_INT" -gt "$MEM_ALERT" ]; then
    STATUS="CRITICAL"
fi

if [ "$DISK" -gt "$DISK_ALERT" ]; then
    STATUS="CRITICAL"
fi

# JSON REPORT
cat > $REPORT <<EOF
{
  "timestamp": "$TIMESTAMP",
  "cpu_usage": "$CPU",
  "memory_usage": "$MEM",
  "disk_usage": "$DISK",
  "failed_ssh": "$FAILED_SSH",
  "status": "$STATUS"
}
EOF

# LOG FILE
echo "[$TIMESTAMP] CPU:$CPU MEM:$MEM DISK:$DISK SSH_FAIL:$FAILED_SSH STATUS:$STATUS" >> $LOG

# OUTPUT
echo "=============================="
echo " INCIDENT REPORT GENERATED"
echo "=============================="
echo "Status: $STATUS"
echo "Report: $REPORT"
echo "Log: $LOG"
