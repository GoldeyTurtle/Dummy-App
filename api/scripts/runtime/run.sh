#!/usr/bin/env bash
set -e

echo "starting run script"

echo "setting env vars"

# TODO this is a hack for local testing
if [ -f .env ]; then
  export $(cat .env | xargs)
else
  TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
  # TODO this is a hack for local testing, we should pull the queue URL from secrets manager or parameter store
  export SQS_QUEUE_URL=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/tags/instance/QUEUE_URL)
  export AWS_DEFAULT_REGION=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/placement/region)
fi

echo "QUEUE_URL = ${QUEUE_URL}"

sudo touch /var/log/app.log && sudo chown ec2-user /var/log/app.log

python3 -m pip install -r requirements.txt --no-cache-dir

# call python app.py and send output to log file and send it to the background
python3 app.py > /var/log/app.log 2>&1 &
