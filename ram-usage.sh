#!/bin/bash
RAM_USAGE=$(free | awk '/Mem:/ {print $3}') # used memory (in KB), for Mb use -m
AVAIL_RAM=$(free | awk '/Mem:/ {print $7}') # available ram
TOTAL_RAM=$(free | awk '/Mem:/ {print $2}') # total memory (in kB)
RAM_THRESHOLD=200000         # 200 MB = 200000 KB
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
MESSAGE=""
TO_ADDRESS="prasannakukunuri35@gmail.com"

if [ "$RAM_USAGE" -ge "$RAM_THRESHOLD" ]; then
  MESSAGE="High RAM Usage Alert! <br> Used RAM: ${RAM_USAGE} KB <br> After Using, Available RAM: ${AVAIL_RAM} KB <br> Total RAM: ${TOTAL_RAM} KB <br>"

  echo "Message body: $MESSAGE"

  # Send HTML email using your gmail.sh
  sh gmail.sh "$TO_ADDRESS" \
  "High RAM Usage Alert" \
  "RAM Usage" \
  "$MESSAGE" \
  "$IP_ADDRESS" \
  "DevOps Team"
else
  echo "RAM usage is normal: ${RAM_USAGE} KB"
fi