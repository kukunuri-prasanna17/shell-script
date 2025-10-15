#!/bin/bash

# Input arguments
TO_ADDRESS=$1
SUBJECT=$2
ALERT_TYPE=$3
MESSAGE_BODY=$4
FORMATTED_BODY=$(printf '%s\n' "$MESSAGE_BODY" | sed -e 's/[]\/$*.^[]/\\&/g')  # Format message body for HTML
IP_ADDRESS=$5
TO_TEAM=$6

# Prepare final HTML email body from template
TEMPLATE_PATH="/home/ec2-user/shell-script/template.html"


if [ ! -f "$TEMPLATE_PATH" ]; then
  echo "Error: HTML template not found at $TEMPLATE_PATH"
  exit 1
fi

FINAL_BODY=$(sed -e "s/TO_TEAM/$TO_TEAM/g" \
                 -e "s/ALERT_TYPE/$ALERT_TYPE/g" \
                 -e "s/IP-ADDRESS/$IP_ADDRESS/g" \
                 -e "s/MESSAGE/$FORMATTED_BODY/g" "$TEMPLATE_PATH")



# Send email using msmtp
{
  echo "To: $TO_ADDRESS"
  echo "Subject: $SUBJECT"
  echo "Content-Type: text/html"
  echo ""
  echo "$FINAL_BODY"
} | msmtp "$TO_ADDRESS"