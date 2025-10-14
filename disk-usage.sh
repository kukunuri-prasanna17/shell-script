#!/bin/bash

DISK_THRESHOLD=2
DISK_USAGE=$(df -hT | grep -v Filesystem)
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 )
MESSAGE=""

while IFS= read -r line
 do
  usage=$(echo $line | awk '{print $6}' | cut -d '%' -f1)
  partition=$(echo $line | awk '{print $7}')
  
  if [ $usage -ge $DISK_THRESHOLD ]; then
    MESSAGE+="High Usage alert on $partition: $usage % <br>"
  fi
done <<< "$DISK_USAGE"

echo -e "Message body: $MESSAGE"

# Call the email script
sh gmail.sh "prasannakukunuri35@gmail.com" "High Usage Alert On Disk Storage" "Disk Usage" "$MESSAGE" "$IP_ADDRESS" "DevOps Team"