#!/bin/bash

PROFILE=$1
REGION=$2
ACTION=$3
ACTION_TIME=$4
OPTION=$(tr '[A-Z]' '[a-z]' <<<${ACTION})

echo "aws ec2 --profile ${PROFILE} describe-tags --region ${REGION} --filters Name=resource-type,Values=instance Name=key,Values=${ACTION} Name=value,Values=${ACTION_TIME} --query 'Tags[*].ResourceId' --output text"

for instanceid in $( aws ec2 --profile ${PROFILE} describe-tags --region ${REGION} --filters Name=resource-type,Values=instance Name=key,Values=${ACTION} Name=value,Values=${ACTION_TIME} --query 'Tags[*].ResourceId' --output text ); do
    aws ec2 ${OPTION}-instances --region=ap-northeast-1 --instance-ids ${instanceid}
    sleep 5s
done
