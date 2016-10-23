from invoke import task
import urllib.request
import time
import boto3


@task
def create_ami(ctx):
    client = boto3.client('ec2', region_name='eu-west-1')
    instance_id = urllib.request.urlopen("http://169.254.169.254/latest/meta-data/instance-id").read().decode("utf-8")
    ami_name = "jenkins-slave_{0}".format(time.strftime("%Y%m%d-%H%M"))
    
    print("\nCreating AMI from {0}...".format(instance_id))

    response = client.create_image(
        Name=ami_name,
        InstanceId=instance_id,
        NoReboot=True
    )
    
    print("\nCreating {1} from {0}...".format(instance_id, response['ImageId']))
    
    waiter = client.get_waiter('image_available')
    waiter.wait(
        ImageIds=[
            response['ImageId']
        ]
    )
    print("\nCreated {0}.".format(response['ImageId']))

