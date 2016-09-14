#!/bin/bash

mkdir archive
cd archive

echo "Downloading DLib 19.1 and OpenCV 3.1.0"
wget http://dlib.net/files/dlib-19.1.tar.bz2
wget https://github.com/opencv/opencv/archive/3.1.0.zip
wget https://julialang.s3.amazonaws.com/bin/linux/x64/0.4/julia-0.4.6-linux-x86_64.tar.gz

echo "Download cuDNN v5.1 Runtime Library for Linux (Deb): libcudnn5_5.1.5-1+cuda8.0_amd64.deb"
echo "Download cuDNN v5.1 Developer Library for Linux (Deb): libcudnn5-dev_5.1.5-1+cuda8.0_amd64.deb"
open https://developer.nvidia.com/rdp/cudnn-download
