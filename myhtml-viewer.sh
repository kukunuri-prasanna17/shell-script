#!/bin/bash
# /usr/bin/my_html_viewer

MY_HTML_FILE="/home/ec2-user/shell-script/template.html"

if [ ! -f "$MY_HTML_FILE" ]; then
    echo "Error: $MY_HTML_FILE not found"
    exit 1
fi

FINAL_BODY=$(sed -e "s/TO_TEAM/$TO_TEAM/g" \
                 -e "s/ALERT_TYPE/$ALERT_TYPE/g" \
                 -e "s/IP-ADDRESS/$IP_ADDRESS/g" \
                 -e "s/MESSAGE/$FORMATTED_BODY/g" "$MY_HTML_FILE")


# Install w3m (if not already installed)
sudo yum install -y w3m  >/dev/null 2>&1   # Use apt for Ubuntu, yum for Amazon Linux

# Convert HTML to plain text
w3m -dump "$MY_HTML_FILE" > extracted_text.txt

# Search for a specific keyword in the extracted text
grep "specific_keyboard" extracted_text.txt

echo "✅ Created w3m dump for HTML file and searched keyword successfully."

