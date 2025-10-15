#!/bin/bash

# Function to calculate CPU usage
calculate_cpu_usage() {
    # Capture the first snapshot of CPU stats
    CPU1=$(grep 'cpu ' /proc/stat | awk '{print $2+$3+$4+$5+$6+$7+$8}')
    IDLE1=$(grep 'cpu ' /proc/stat | awk '{print $5}')

    # Wait for a second
    sleep 1

    # Capture the second snapshot of CPU stats
    CPU2=$(grep 'cpu ' /proc/stat | awk '{print $2+$3+$4+$5+$6+$7+$8}')
    IDLE2=$(grep 'cpu ' /proc/stat | awk '{print $5}')

    # Calculate the differences
    CPU_DIFF=$((CPU2 - CPU1))
    IDLE_DIFF=$((IDLE2 - IDLE1))

    # Calculate CPU usage percentage
    CPU_USAGE=$((100 * (CPU_DIFF - IDLE_DIFF) / CPU_DIFF))

    echo "Current CPU Usage: $CPU_USAGE%"
}

# Run the function
calculate_cpu_usage
