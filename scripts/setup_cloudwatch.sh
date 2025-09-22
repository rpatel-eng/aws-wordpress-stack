#!/bin/bash
set -e

REGION=$(jq -r '.region' ../lambda/config.json)

echo "Creating CloudWatch rules..."

aws events put-rule --name "StartEC2Schedule" --schedule-expression "cron(0 9 * * ? *)" --region $REGION
aws events put-targets --rule "StartEC2Schedule" --targets "Id"="1","Arn"=$(aws lambda get-function --function-name StartEC2Instance --region $REGION --query 'Configuration.FunctionArn' --output text) --region $REGION

aws events put-rule --name "StopEC2Schedule" --schedule-expression "cron(0 18 * * ? *)" --region $REGION
aws events put-targets --rule "StopEC2Schedule" --targets "Id"="1","Arn"=$(aws lambda get-function --function-name StopEC2Instance --region $REGION --query 'Configuration.FunctionArn' --output text) --region $REGION

echo "CloudWatch scheduling complete."
