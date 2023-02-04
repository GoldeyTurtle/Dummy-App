# Build and deploy process

## Build

From `api/` directory, run `bash scripts/build/build.sh`

This creates an `app.zip` file with a python virtual environment and the source code.

This artifact will be uploaded to S3 and downloaded on startup by instances.

## Deploy

Instances retrieve the `app.zip` file from S3, unzip it, and run the `scripts/runtime/run.sh` script

## Testing this process

Make sure you don't have an active virtual environment

Run `bash scripts/local/test_build_process.sh`

