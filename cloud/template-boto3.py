import boto3
import os

os.environ['AWS_SESSION_TOKEN']
os.environ['AWS_SECRET_ACESS_KEY']
os.environ['AWS_ACESS_KEY_ID']

s3 = boto3.resource('s3')
for bucket in s3.buckets.all():
    print(bucket.name)
