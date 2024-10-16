#!/bin/bash

OUTPUT_CSV="/home/ubuntu/AWS/scripts/profile/output/ec2_instances.csv"

echo "Sr. No,InstanceID,InstanceName,InstanceState,InstanceType,AvailabilityZone,PublicIpAddress,PrivateIpAddress,VpcId,SubnetId,KeyName" > "$OUTPUT_CSV"

aws ec2 describe-instances --query 'Reservations[*].Instances[*]' --output json | jq -r '.[] | .[] | [.InstanceId, (.Tags[] | select(.Key=="Name").Value), .State.Name, .InstanceType, .Placement.AvailabilityZone, .PublicIpAddress, .PrivateIpAddress, .VpcId, .SubnetId, .KeyName] | @csv' | awk '{print NR "," $0}' >> "$OUTPUT_CSV"

echo "EC2 instance details exported to $OUTPUT_CSV"