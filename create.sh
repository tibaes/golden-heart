#!/bin/bash

image="goldenheart"
version="1.0.0"

cat modules/core.txt > Dockerfile
cat modules/cplusplus.txt >> Dockerfile
cat modules/julia.txt >> Dockerfile

docker build -t ${image}:${version} .
