# AWS Console Setup

1. Deploy CloudFormation stack using wordpress-template.yaml
2. Fill in KeyName, DBName, DBUser, DBPassword, DBRootPassword
3. Wait for stack creation
4. Open WebsiteURL output and finish WordPress setup
5. Create IAM Role for Lambda with EC2 start/stop permissions
6. Create Lambda functions (start_instance.py, stop_instance.py) and attach role
7. Create CloudWatch rules to schedule start at 9 AM, stop at 6 PM
