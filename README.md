# Architecture

## API

The API consists of a Python application running on EC2 instances behind an Application Load Balancer.

The API sends requests to an SQS queue.

## SQS Consumer

The SQS consumer is a Python application running in Lambda.

The SQS consumer reads messages from the SQS queue and puts them in S3.

## Technologies Used

- EC2
  - Autoscaling
- ELB
- Route53
- SQS
- IAM
- S3
- ACM
