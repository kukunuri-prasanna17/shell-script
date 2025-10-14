#!/bin/bash
RAM_USAGE=$(free | awk '{print $3}' | grep -v used | grep -v free)
PARTITION=$(free | awk '{print $1}' | grep -v total)
IP_ADDRESS=$(curl  http://169.254.169.254/latest/meta-data/public-ipv4)
MESSAGE=" "
MESSAGE="High Usage On $PARTITION: $RAM_USAGE"
RAM_THRESHOLD=20000

if [ $RAM_USAGE -ge $RAM_THRESHOLD ]; then
   echo "Message body: $MESSAGE"
sh gmail.sh "prasannakukunuri35@gmail.com" "High Alret Usage" "High Usage on RAM" "$MESSAGE" "$IP_ADDRESS" "DevOps Team,"
  else
   echo "RAM Storage is normal condition"
fi


# TO_ADDRESS=$1
# SUBJECT=$2
# ALERT_TYPE=$3
# MESSAGE_BODY=$4
# IP_ADDRESS=$5
# TO_TEAM=$6