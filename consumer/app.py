import json
import boto3
import os
import uuid

# Create client in a global scope so that they're reused between invocations
s3_client = boto3.client('s3')


def lambda_handler(event, context):
    # Log message
    print("Received event: " + json.dumps(event, indent=2))

    # For each record in the sqs message, create a UUID and upload to S3
    for record in event['Records']:
        # Get the message body
        message_body = record['body']
        # Create a UUID
        _uuid = str(uuid.uuid4())
        # Upload the message body to S3
        try:
            s3_client.put_object(Body=message_body, Bucket=os.environ['S3_BUCKET'], Key=_uuid)
            print("Uploaded message to S3: {}".format(_uuid))
        except Exception as e:
            print("Error uploading to S3: {}".format(e))
            raise e

