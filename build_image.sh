#!/bin/sh

RELEASE=v9.1.1
BUILD_DIR=bionic

docker build -t dealii/dealii:$RELEASE-$BUILD_DIR $BUILD_DIR
docker push dealii/dealii:$RELEASE-$BUILD_DIR