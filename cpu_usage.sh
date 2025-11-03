#!/bin/bash

# Get first snapshot of CPU stats
CPU1=$(grep 'cpu ' /proc/stat | awk '{used=$2+$3+$4; idle=$5; print used, idle}')
USED1=$(echo $CPU1 | awk '{print $1}')
IDLE1=$(echo $CPU1 | awk '{print $2}')

# Wait 1 second
sleep 1
''
# Get second snapshot
CPU2=$(grep 'cpu ' /proc/stat | awk '{used=$2+$3+$4; idle=$5; print used, idle}')
USED2=$(echo $CPU2 | awk '{print $1}')
IDLE2=$(echo $CPU2 | awk '{print $2}')

# Calculate CPU usage
USED_DIFF=$((USED2 - USED1))
IDLE_DIFF=$((IDLE2 - IDLE1))
TOTAL=$((USED_DIFF + IDLE_DIFF))


CPU_USED=$(( 100 * USED_DIFF / TOTAL ))
CPU_AVAILABLE=$((100 - CPU_USED))

echo "CPU Used: $CPU_USED %"
echo "CPU Available: $CPU_AVAILABLE %"

# Call the email script
sh gmail.sh "prasannakukunuri35@gmail.com" "High Usage Alert On Disk Storage" "Disk Usage" "$MESSAGE" "$IP_ADDRESS" "DevOps Team"
