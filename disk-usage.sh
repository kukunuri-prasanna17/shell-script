#!/bin/bash
# export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# DISK_THRESHOLD=2
# DISK_USAGE=$(df -hT | grep -v Filesystem)
# IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
# MESSAGE=""

# while IFS= read -r line
#  do
#   usage=$(echo $line | awk '{print $6}' | cut -d '%' -f1)
#   partition=$(echo $line | awk '{print $7}')
  
#   if [ $usage -ge $DISK_THRESHOLD ]; then
#     MESSAGE+="High Usage alert on $partition: $usage % <br>"
#   fi
# done <<< "$DISK_USAGE"

# echo -e "Message body: $MESSAGE"

# # Call the email script
# sh gmail.sh "prasannakukunuri35@gmail.com" "High Usage Alert On Disk Storage" "Disk Usage" "$MESSAGE" "$IP_ADDRESS" "DevOps Team"

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Absolute paths
GMAIL_SCRIPT="/home/ec2-user/bin/gmail.sh"
MY_HTML_FILE="/home/ec2-user/shell-script/template.html"

# Disk threshold
DISK_THRESHOLD=2

# Get disk usage
DISK_USAGE=$(df -hT | grep -v Filesystem)

# Get instance public IP
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# Prepare message
MESSAGE=""

while IFS= read -r line
do
  usage=$(echo "$line" | awk '{print $6}' | cut -d'%' -f1)
  partition=$(echo "$line" | awk '{print $7}')
  
  if [ "$usage" -ge "$DISK_THRESHOLD" ]; then
    MESSAGE+="High Usage alert on $partition: $usage % <br>"
  fi
done <<< "$DISK_USAGE"

echo -e "Message body: $MESSAGE"

# Check gmail script exists
if [ ! -f "$GMAIL_SCRIPT" ]; then
  echo "Error: $GMAIL_SCRIPT not found"
  exit 1
fi

# Send email (with full path to gmail.sh)
sh "$GMAIL_SCRIPT" "prasannakukunuri35@gmail.com" \
                  "High Usage Alert On Disk Storage" \
                  "Disk Usage" \
                  "$MESSAGE" \
                  "$IP_ADDRESS" \
                  "DevOps Team"
