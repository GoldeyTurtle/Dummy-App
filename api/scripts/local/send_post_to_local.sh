#!/usr/bin/env bash

curl -X POST -d '{"message": "hello world"}' -H "Content-Type: application/json" http://localhost:5000/api/message
