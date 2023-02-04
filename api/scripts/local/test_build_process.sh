#!/usr/bin/env bash

mkdir tmp/

bash scripts/build/build.sh

mv app.zip tmp/

cp .env tmp/

cd tmp/

unzip app.zip

bash scripts/runtime/run.sh
