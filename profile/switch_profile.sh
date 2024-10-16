#!/bin/bash

rm /home/ubuntu/AWS/scripts/profile/output/*

output_dir="/home/ubuntu/AWS/scripts/profile/output"
bash_script="/home/ubuntu/AWS/scripts/fetch/fetch_ec2_instances.sh"
current_month_year=$(date +'%B %Y')

# Old PROD Account
export AWS_PROFILE=inv-admin
sh "$bash_script"
sleep 3
mv "$output_dir/ec2_instances.csv" "$output_dir/oldprod_ec2_instances.csv"

# Dev Account
export AWS_PROFILE=inv-dev
sh "$bash_script"
sleep 3
mv "$output_dir/ec2_instances.csv" "$output_dir/dev_ec2_instances.csv"

# UAT Account
export AWS_PROFILE=inv-uat
sh "$bash_script"
sleep 3
mv "$output_dir/ec2_instances.csv" "$output_dir/uat_ec2_instances.csv"

# PROD Account
export AWS_PROFILE=default
sh "$bash_script"
sleep 3
mv "$output_dir/ec2_instances.csv" "$output_dir/prod_ec2_instances.csv"

# shared Account
export AWS_PROFILE=inv-shared
sh "$bash_script"
sleep 3
mv "$output_dir/ec2_instances.csv" "$output_dir/sharedservice_ec2_instances.csv"

# Network Account
export AWS_PROFILE=inv-network
sh "$bash_script"
sleep 3
mv "$output_dir/ec2_instances.csv" "$output_dir/network_ec2_instances.csv"

# Zip the CSV files
zip -j "$output_dir/EC2_Inventory.zip" "$output_dir/"*.csv

# Run the script to fetch the EC2 count
ec2_count="/home/ubuntu/AWS/scripts/fetch/fetch_ec2_count.sh"
bash "$ec2_count"