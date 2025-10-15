#!/bin/bash
# /usr/bin/my_html_viewer

# Use correct Linux path — backslashes (\) don’t work in bash
MY_HTML_FILE="/home/ec2-user/shell-script/template.html"

# Check if file exists (space is required before closing bracket)
if [ ! -f "$MY_HTML_FILE" ]; then
   echo "The file $MY_HTML_FILE doesn't exist."
   exit 1
fi

# Install w3m (if not already installed)
sudo yum install -y w3m  >/dev/null 2>&1   # Use apt for Ubuntu, yum for Amazon Linux

# Convert HTML to plain text
w3m -dump "$MY_HTML_FILE" > extracted_text.txt

# Search for a specific keyword in the extracted text
grep "specific_keyboard" extracted_text.txt

echo "✅ Created w3m dump for HTML file and searched keyword successfully."


