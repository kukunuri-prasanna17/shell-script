#!/bin/bash
  # RAM_THRESHOLD=20000
# IP_ADDRESS=$(curl -s ifconfig.me)
# MESSAGE=" "

# while IFS= read -r line
# do
# RAM_USAGE=$(free | awk '{print $3}' | grep -v used | grep -v free)
# PARTITION=$(free | awk '{print $1}' | grep -v total)
# if [ $RAM_USAGE -ge $RAM_THRESHOLD ]; then
#    MESSAGE="High Usage On $PARTITION: $RAM_USAGE"
#   else
#    echo "RAM Storage is normal condition"
# fi
# done <<< $RAM_USAGE

# echo  "Message body: $MESSAGE"

# sh gmail.sh "prasannakukunuri35@gmail.com" "High Alret Usage" "High Usage on RAM" "$MESSAGE" "$IP_ADDRESS" "DevOps Team,"


#!/bin/bash
# RAM usage alert script

RAM_USAGE=$(free | awk '/Mem:/ {print $3}')     # used memory (in KB)
RAM_THRESHOLD=200000                            # 200 MB = 200000 KB
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
MESSAGE=""
TO_ADDRESS="prasannakukunuri35@gmail.com"

if [ "$RAM_USAGE" -ge "$RAM_THRESHOLD" ]; then
  MESSAGE="High RAM Usage Alert! <br> Used RAM: ${RAM_USAGE} KB <br> Threshold: ${RAM_THRESHOLD} KB <br> Instance IP: ${IP_ADDRESS}"

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
