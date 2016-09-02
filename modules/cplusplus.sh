#!/bin/bash

aptitude update
aptitude install -y build-essential cmake cmake-curses-gui ninja-build pkg-config
aptitude install -y libx11-dev libopenblas-dev liblapack-dev

# opencv

opencv_version="3.1.0"
cd /tmp
wget https://github.com/Itseez/opencv/archive/$opencv_version.zip
unzip $opencv_version.zip
git clone https://github.com/Itseez/opencv_contrib.git
mkdir opencv-$opencv_version/build
cd opencv-$opencv_version/build
cmake .. -G"Ninja" -DCMAKE_BUILD_TYPE=RELEASE -DENABLE_AVX2=ON -DENABLE_SSE42=ON
ninja
ninja install

# dlib

dlib_version="19.1"
cd /tmp
wget http://dlib.net/files/dlib-$dlib_version.tar.bz2
tar xjf dlib-$dlib_version.tar.bz2
mkdir dlib-$dlib_version/build
cd dlib-$dlib_version/build
cmake .. -G"Ninja" -DCMAKE_BUILD_TYPE=RELEASE
ninja
ninja install
