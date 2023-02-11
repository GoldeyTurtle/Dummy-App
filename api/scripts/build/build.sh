#!/usr/bin/env bash

set -e

# Script must be run from the api/ dir
# via bash ./scripts/build/build.sh

#python3 -m venv app_venv
#source app_venv/bin/activate
#pip install -r requirements.txt --no-cache-dir
#deactivate

# Zip the venv and the app, include the scripts/runtime dir
#zip -r app.zip app_venv/ app.py scripts/runtime/

zip -r app.zip app.py requirements.txt scripts/runtime/
