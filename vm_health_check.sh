#!/bin/bash

# Function to print usage
usage() {
    echo "Usage: $0 [explain]"
    echo "  explain   : Prints reasons for health status in addition to the health status."
    exit 1
}

# Check for valid arguments
if [ "$#" -gt 1 ]; then
    usage
fi

EXPLAIN=0
if [ "$1" == "explain" ]; then
    EXPLAIN=1
elif [ ! -z "$1" ]; then
    usage
fi

# --- CPU Utilization ---
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1)
cpu_usage=$((100 - cpu_idle))

# --- Memory Utilization ---
mem_total=$(free | awk '/Mem:/ {print $2}')
mem_used=$(free | awk '/Mem:/ {print $3}')
mem_usage=$((mem_used * 100 / mem_total))

# --- Disk Utilization (Root Partition) ---
disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

# --- Health Check ---
HEALTHY=1
REASONS=""

if [ "$cpu_usage" -ge 60 ]; then
    HEALTHY=0
    REASONS="${REASONS}\nReason: CPU usage is above threshold (${cpu_usage}%)"
fi

if [ "$mem_usage" -ge 60 ]; then
    HEALTHY=0
    REASONS="${REASONS}\nReason: Memory usage is above threshold (${mem_usage}%)"
fi

if [ "$disk_usage" -ge 60 ]; then
    HEALTHY=0
    REASONS="${REASONS}\nReason: Disk usage is above threshold (${disk_usage}%)"
fi

if [ "$HEALTHY" -eq 1 ]; then
    HEALTH_STATUS="HEALTHY"
    if [ "$EXPLAIN" -eq 1 ]; then
        echo -e "State of Virtual Machine: $HEALTH_STATUS"
        echo "All resource usages are below 60%:"
        echo "  CPU usage:    ${cpu_usage}%"
        echo "  Memory usage: ${mem_usage}%"
        echo "  Disk usage:   ${disk_usage}%"
    else
        echo "State of Virtual Machine: $HEALTH_STATUS"
    fi
else
    HEALTH_STATUS="NOT HEALTHY"
    if [ "$EXPLAIN" -eq 1 ]; then
        echo -e "State of Virtual Machine: $HEALTH_STATUS"
        echo -e "$REASONS"
        echo "Current usages:"
        echo "  CPU usage:    ${cpu_usage}%"
        echo "  Memory usage: ${mem_usage}%"
        echo "  Disk usage:   ${disk_usage}%"
    else
        echo "State of Virtual Machine: $HEALTH_STATUS"
    fi
fi
