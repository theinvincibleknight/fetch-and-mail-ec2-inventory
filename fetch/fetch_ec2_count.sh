#!/bin/bash

# Output file
output_file="/home/ubuntu/AWS/scripts/profile/output/output.txt"

# Create or clear the output file
> "$output_file"

echo "-------------------------------------" >> "$output_file"

# Define the AWS profiles to iterate over
profiles=("inv-admin" "inv-dev" "inv-uat" "inv-shared" "inv-network")

# Loop over each profile
for profile in "${profiles[@]}"; do
    # Export the current AWS profile
    export AWS_PROFILE=$profile

    # Get the total number of EC2 instances
    total_instances=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output text | wc -w)

    # Get the number of running EC2 instances
    running_instances=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].InstanceId' --output text | wc -w)

    # Get the number of stopped EC2 instances
    stopped_instances=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query 'Reservations[*].Instances[*].InstanceId' --output text | wc -w)

    # Print the results for the current profile
    echo "AWS Account: $profile" >> "$output_file"
    echo "Running Instances: $running_instances" >> "$output_file"
    echo "Stopped Instances: $stopped_instances" >> "$output_file"
    echo "Total Instances: $total_instances" >> "$output_file"
    echo "-------------------------------------" >> "$output_file"
done

# PROD Account
export AWS_PROFILE=default
echo "AWS Account: inv-prod" >> "$output_file"

running_instances=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].InstanceId' --output text | wc -w)
echo "Running Instances: $running_instances" >> "$output_file"

stopped_instances=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --query 'Reservations[*].Instances[*].InstanceId' --output text | wc -w)
echo "Stopped Instances: $stopped_instances" >> "$output_file"

total_instances=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output text | wc -w)
broker_layer=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=broker-layer-auto-scaling-group" --query 'Reservations[*].Instances[*].InstanceId' --output text | wc -w)
echo "Total Instances: $total_instances (includes $broker_layer broker-layer-auto-scaling-group instances)" >> "$output_file"

# broker_layer=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=broker-layer-auto-scaling-group" --query 'Reservations[*].Instances[*].InstanceId' --output text | wc -w)
# echo "Number of broker-layer-auto-scalling-group instances: $broker_layer" >> "$output_file"

echo "-------------------------------------" >> "$output_file"