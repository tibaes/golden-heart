# Golden Heart, a container for high performance computer vision research

*Ennyn Durin aran Moria. Pedo mellon a minno.*

This container focuses in high performance computer vision and machine learning research.
It was designed targeting the  [Nvidia CUDA docker platform](https://devblogs.nvidia.com/parallelforall/nvidia-docker-gpu-server-application-deployment-made-easy/),
so it uses the image of the Nvidia CUDA 8.0 framework.
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

## Install

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


*Im Narvi hain echant: Celebrimbor o Eregion teithant i thiw hin.*
