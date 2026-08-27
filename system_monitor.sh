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

echo "---- CPU HEALTH CHECK ----" >> "$LOG_FILE"

CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {printf "%.0f", 100 - $8}')

if [ "$CPU_USAGE" -ge 80 ]; then
    echo "WARNING: CPU usage is ${CPU_USAGE}%" >> "$LOG_FILE"
else
    echo "OK: CPU usage is ${CPU_USAGE}%" >> "$LOG_FILE"
fi

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
echo "---- MEMORY HEALTH CHECK ----" >> "$LOG_FILE"

MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')

if [ "$MEMORY_USAGE" -ge 80 ]; then
    echo "WARNING: Memory usage is ${MEMORY_USAGE}%" >> "$LOG_FILE"
else
    echo "OK: Memory usage is ${MEMORY_USAGE}%" >> "$LOG_FILE"
fi

echo "---- SWAP HEALTH CHECK ----" >> "$LOG_FILE"

SWAP_USAGE=$(free | awk '/Swap:/ {if ($2 == 0) print 0; else printf "%.0f", ($3/$2)*100}')

if [ "$SWAP_USAGE" -ge 50 ]; then
    echo "WARNING: Swap usage is ${SWAP_USAGE}%" >> "$LOG_FILE"
else
    echo "OK: Swap usage is ${SWAP_USAGE}%" >> "$LOG_FILE"
fi
