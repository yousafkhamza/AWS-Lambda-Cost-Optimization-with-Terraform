import boto3

REGION = "ap-south-1"

def lambda_handler(event, context):
    ec2 = boto3.client('ec2',region_name=REGION)
    all_ec2 = ec2.describe_instances(
        Filters=[
        {'Name':'tag:Name', 'Values':["python"]}
        ])

    for instance in all_ec2['Reservations'][0]['Instances']:
        print("Starting Ec2 : {} ".format( instance['InstanceId'] ))
        ec2.start_instances(InstanceIds=[ instance['InstanceId'] ])