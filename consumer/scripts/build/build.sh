#!/usr/bin/env bash

# must be run from the consumer/ directory
mkdir build

cp app.py ./build
cp requirements.txt ./build

cd build

pip install -r requirements.txt --no-cache-dir -t ./

zip -r app.zip ./

mv app.zip ../

cd ../

rm -rf build/
