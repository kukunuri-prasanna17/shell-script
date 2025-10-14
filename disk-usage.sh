#!/bin/bash
TO_ADDRESS=$1
SUBJECT=$2
ALERT_TYPE=$3
MESSAGE_BODY=$4
IP_ADDRESS=$5
TO_TEAM=$6
FORMATTED_BODY=$(printf '$s/n' "$MESSAGE_BODY" | sed -e  's/[]\/$*.^[]/\\&/g')

FINAL_BODY=$(sed -e "s/TO_TEAM/$TO_TEAM/g" -e "s/ALERT_TYPE/$ALERT_TYPE/g" -e "s/iP-ADDRESS/$IP_ADDRESS/g" -e "s/MESSAGE/$FORMATTED_BODY/g" template.html)

{
echo "To: $TO_ADDRESS"
echo "Subject: $SUBJECT"
echo "Content-Type: text/html"
echo ""
echo "$FINAL_BODY"
} | msmtp "$TO_ADDRESS"
DISK_USAGE=$(df -hT | grep -v filesystem)
DISK_THRESHOLD=2
IP_ADDRESS= curl -s http://169.254.169.254/latest/meta-data/public-ipv4
MESSAGE=" "

while IFS= read disk
do 
  usage=$(echo $disk df -hT | grep -v filesystem | awk '{print $6}' | cut -d "%" -f1)
  parition=$(echo $disk df -hT | grep -v filesystem | awk '{print $7}')
 if [ $usage -ge $DISK_THRESHOLD ]; then
   MESSAGE+="High Usage alert on $parition:$usage % <br>"
 fi
done <<< $DISK_USAGE

echo -e "Message body: $MESSAGE"

sh mail.sh "prasanankukunuri35@gmail.com" "High Usage Alert On Disk Storage" "Disk Usage" "$MESSAGE" "$IP_ADDRESS" "DevOps Team,"

# TO_ADDRESS=$1
# SUBJECT=$2
# ALERT_TYPE=$3
# MESSAGE_BODY=$4
# IP_ADDRESS=$5
# TO_TEAM=$6