import os

from flask import Flask, request
import boto3

app = Flask(__name__)
sqs_client = boto3.client('sqs')


@app.route('/api/message', methods=['POST'])
def index():
    if request.is_json:
        content = request.get_json()
        message = content.get('message', '')

        # send the message to the SQS queue
        if not app.config['DISABLE_SQS_SEND']:
            sqs_client.send_message(QueueUrl=app.config["SQS_QUEUE_URL"], MessageBody=message)
        else:
            print("sending message is disabled but here it is anyway: {}".format(message))

        return 'Message sent to SQS queue', 200
    else:
        return 'Invalid request', 400


def set_configuration_for_app():
    """
    Set the configuration for the app
    """
    app.config['SQS_QUEUE_URL'] = os.environ['SQS_QUEUE_URL']
    # Hack to simplify testing
    app.config['DISABLE_SQS_SEND'] = os.environ.get("DISABLE_SQS_SEND", False)

if __name__ == '__main__':
    set_configuration_for_app()
    if not app.config['DISABLE_SQS_SEND']:
        app.run(host="0.0.0.0")
    else:
        app.run()
