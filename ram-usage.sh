#!/bin/bash
RAM_THRESHOLD=20000
IP_ADDRESS=$(curl -s ifconfig.me)
MESSAGE=" "

while IFS= read -r line
do
RAM_USAGE=$(free | awk '{print $3}' | grep -v used | grep -v free)
PARTITION=$(free | awk '{print $1}' | grep -v total)
if [ $RAM_USAGE -ge $RAM_THRESHOLD ]; then
   MESSAGE="High Usage On $PARTITION: $RAM_USAGE"
  else
   echo "RAM Storage is normal condition"
fi
done <<< $RAM_USAGE

echo  "Message body: $MESSAGE"

sh gmail.sh "prasannakukunuri35@gmail.com" "High Alret Usage" "High Usage on RAM" "$MESSAGE" "$IP_ADDRESS" "DevOps Team,"


# TO_ADDRESS=$1
# SUBJECT=$2
# ALERT_TYPE=$3
# MESSAGE_BODY=$4
# IP_ADDRESS=$5
# TO_TEAM=$6