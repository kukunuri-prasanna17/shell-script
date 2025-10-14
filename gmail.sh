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