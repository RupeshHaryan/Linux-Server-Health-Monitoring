#!/bin/bash

LOG_FILE="$HOME/system_health.log"

echo "========================================" >> "$LOG_FILE"
echo "       LINUX SERVER HEALTH REPORT       " >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
echo "Date: $(date)" >> "$LOG_FILE"
echo "Hostname: $(hostname)" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

echo "---- CPU LOAD ----" >> "$LOG_FILE"
uptime >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

echo "---- MEMORY USAGE ----" >> "$LOG_FILE"
free -h >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

echo "---- DISK USAGE ----" >> "$LOG_FILE"
df -h / >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

echo "---- TOP PROCESSES ----" >> "$LOG_FILE"
ps aux --sort=-%cpu | head -6 >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

echo "---- SYSTEM HEALTH CHECK COMPLETED ----" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
echo "---- DISK HEALTH CHECK ----" >> "$LOG_FILE"

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$DISK_USAGE" -ge 80 ]; then
    echo "WARNING: Disk usage is ${DISK_USAGE}%" >> "$LOG_FILE"
else
    echo "OK: Disk usage is ${DISK_USAGE}%" >> "$LOG_FILE"
fi

echo "----------------------------------------" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"
