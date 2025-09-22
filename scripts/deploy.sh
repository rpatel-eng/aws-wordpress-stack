#!/bin/bash
set -e

echo "Packaging and deploying Lambda functions..."

cd ../lambda
zip -r ../start_instance.zip start_instance.py utils.py config.json
zip -r ../stop_instance.zip stop_instance.py utils.py config.json
cd ..

aws lambda create-function --function-name StartEC2Instance --runtime python3.9 --role arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):role/EC2StartStopLambdaRole --handler start_instance.lambda_handler --zip-file fileb://start_instance.zip || aws lambda update-function-code --function-name StartEC2Instance --zip-file fileb://start_instance.zip

aws lambda create-function --function-name StopEC2Instance --runtime python3.9 --role arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):role/EC2StartStopLambdaRole --handler stop_instance.lambda_handler --zip-file fileb://stop_instance.zip || aws lambda update-function-code --function-name StopEC2Instance --zip-file fileb://stop_instance.zip

echo "Deployment completed."
