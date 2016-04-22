#!/bin/bash

repo="tjhei"

docker build -t $repo/ubuntu14 ubuntu14/ || exit 1
docker build -t $repo/dealii-base base/ || exit 1

ver="v8.4.1"
docker build -t $repo/dealii-bare:$ver --build-arg VER=$ver bare/ || exit 1
ver="master"
docker build -t $repo/dealii-bare:$ver --build-arg VER=$ver bare/ || exit 1

docker build -t $repo/dealii-full-deps:v0.3 full-deps/ || exit 1

ver="v8.4.1"
docker build -t $repo/dealii:v8.4.1 --build-arg VER=$ver deal/ || exit 1

