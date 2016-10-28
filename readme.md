# Golden Heart, a container for high performance computer vision research

*Ennyn Durin aran Moria. Pedo mellon a minno.*

This container focuses in high performance computer vision and machine learning research.
It was designed targeting the Nvidia CUDA docker platform, so it uses the image of the Nvidia CUDA 8.0 framework.
This container requires CUDNN, however this is a proprietary library from NVidia and need to be downloaded manually.
Above all this CUDA framework we install OpenCV and DLib with all GPU and CPU optimizations enabled by default.
Also, we install Python3, Julia and Jupyter for running notebooks remotely.
Naturally, OpenCV and DLib are compiled with CUDA and python support, so
you can run your computer vision python notebooks with the highest performance.

## Features

* All the advantages of docker containers
* NVidia CUDA 8.0 framework
* CUDNN for running deep learning using GPU
* OpenCV 3.1, patched for CUDA 8.0
* DLib 19.1
* Python 3
* Julia 0.4.6
* Jupyter notebooks
* Fish shell, tmux and screen
* C/C++, CMake and ninja builder
* Vim with some useful plugins

## Requirements

The only minimal requirement is the docker platform.
However, to run computations in GPU you must have a Nvidia CUDA enabled card and
install the [Nvidia CUDA docker platform](https://devblogs.nvidia.com/parallelforall/nvidia-docker-gpu-server-application-deployment-made-easy/).

## Install

As the building procedure requires proprietary CuDNN, you must download it manually.
The Dockerfile will search in the *archive* directory for the required files.
Also, Julia, Dlib and OpenCV must be downloaded manually.
We opted for manual download instead of letting it inside dockerfile for two reasons:
in case of errors, you do not need to spend a lot of time downloading these giant files again;
and CuDNN requires manual download anyway.
In a future release, we may put OpenCV, Dlib and Julia inside the Dockerfile, however we do not have a legal solution for CuDNN.
So, you need to create the *archive* directory and put the binaries there:


```
mkdir archive
cd archive

wget http://dlib.net/files/dlib-19.1.tar.bz2
wget https://github.com/opencv/opencv/archive/3.1.0.zip
wget https://julialang.s3.amazonaws.com/bin/linux/x64/0.4/julia-0.4.6-linux-x86_64.tar.gz
```

Now, open the [CuDNN download site](https://developer.nvidia.com/rdp/cudnn-download) and download the runtime and develop libraries for Debian 64bits & CUDA 8: *libcudnn5_5.1.5-1+cuda8.0_amd64.deb* and *libcudnn5-dev_5.1.5-1+cuda8.0_amd64.deb*. Put these files inside the *archive* directory.

In the same directory as the Dockerfile, run:

```
docker build -t goldenheart:1.2.0 .
```

If your CPU does not have advanced instructions, as AVX2 and SSE4.2, you must
override these flags in OpenCV. In this case, replace the above command with:

```
docker build --build-arg OPENCV_FLAGS="" -t goldenheart:1.2.0 .
```

## Configuration

Default jupyter password is "friend"; default port: 9999.
Just in case you want another password, run inside python:

***
from notebook.auth import passwd
passwd()
***

Copy the result and replace the c.NotebookApp.password inside jupyter_notebook_config.py.
If you want another port, change the c.NotebookApp.port parameter.
And in case you want to replace the certificates for ssl, run:

***
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mykey.key -out mycert.pem
***

More information about secure jupyter notebooks can be found in the [project documentation](http://jupyter-notebook.readthedocs.org/en/latest/public_server.html).

## Running Jupyter



*Im Narvi hain echant: Celebrimbor o Eregion teithant i thiw hin.*
