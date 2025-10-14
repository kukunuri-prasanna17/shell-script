#!/bin/bash

# DISK_USAGE=$(df -hT | grep -v filesystem)
# DISK_THRESHOLD=2
# IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
# MESSAGE=" "

# while IFS= read -r read disk
# do 
#   usage=$(echo $disk df -hT | grep -v filesystem | awk '{print $6}' | cut -d "%" -f1)
#   parition=$(echo $disk df -hT | grep -v filesystem | awk '{print $7}')
#  if [ $usage -ge $DISK_THRESHOLD ]; then
#    MESSAGE+="High Usage alert on $parition: $usage % <br>"
#  fi
# done <<< $DISK_USAGE

# echo -e "Message body: $MESSAGE"

# sh gmail.sh "prasannakukunuri35@gmail.com" "High Usage Alert On Disk Storage" "Disk Usage" "$MESSAGE" "$IP_ADDRESS" "DevOps Team,"

# # TO_ADDRESS=$1
# # SUBJECT=$2
# # ALERT_TYPE=$3
# # MESSAGE_BODY=$4
# # IP_ADDRESS=$5
# # TO_TEAM=$6

DISK_THRESHOLD=2
DISK_USAGE=$(df -hT | grep -v filesystem)
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
MESSAGE=""

while IFS= read -r line; do
  usage=$(echo "$line" | awk '{print $6}' | tr -d '%')
  partition=$(echo "$line" | awk '{print $7}')
  
  if [ "$usage" -ge "$DISK_THRESHOLD" ]; then
    MESSAGE+="High Usage alert on $partition: $usage% <br>"
  fi
done <<< "$DISK_USAGE"

echo -e "Message body: $MESSAGE"

# Call the email script
sh gmail.sh "prasannakukunuri35@gmail.com" "High Usage Alert On Disk Storage" "Disk Usage" "$MESSAGE" "$IP_ADDRESS" "DevOps Team"