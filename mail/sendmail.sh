#!/bin/bash

current_month_year=$(date +'%B %Y')
email_recipient="john.doe@company.com,tom.hanks@company.com,peter.parker@company.com"
from_recipient="noreply@company.com"
email_subject="EC2 Instance Details | ${current_month_year}"
zip_file="/home/ubuntu/AWS/scripts/profile/output/EC2_Inventory.zip"
output_file="/home/ubuntu/AWS/scripts/profile/output/output.txt"

# Construct email body
email_body="Hello,\n\nPlease find the EC2 instance details for ${current_month_year}\n\n"
signature="\n\nThanks & Regards,\nAWS Administrator"

# Send email with the content of output.txt as the body and attach the zip file
{
  echo "$email_body"
  cat "$output_file"
  echo "$signature"
} | mail -s "$email_subject" -A "$zip_file" "$email_recipient" -a "FROM:$from_recipient"