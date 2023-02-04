#!/usr/bin/env bash

echo "starting run script"

echo "setting env vars"

# TODO this is a hack for local testing
if [ -f .env ]; then
  export $(cat .env | xargs)
else
  TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
  # TODO this is a hack for local testing, we should pull the queue URL from secrets manager or parameter store
  curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/tags/instance/QUEUE_URL
fi

source app_venv/bin/activate
python app.py
