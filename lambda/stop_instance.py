import boto3
from utils import load_config

def lambda_handler(event, context):
    config = load_config()
    ec2 = boto3.client("ec2", region_name=config["region"])
    instance_id = config["instance_id"]
    ec2.stop_instances(InstanceIds=[instance_id])
    return {"status": "success", "action": "stop", "instance_id": instance_id}
