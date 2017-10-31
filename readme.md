# Golden Heart

* A container for high performance computer vision.

***

This container focuses on high performance computer vision research.
It was designed targeting the Nvidia CUDA docker platform, so it is based on the Nvidia CUDA 9.0+CUDNN docker image.
Above the CUDA framework we install OpenCV with GPU and CPU optimizations enabled by default.
Also, we install Python3, Julia and Jupyter for running notebooks.
Naturally, OpenCV is compiled with CUDA and python support, so
you can run your computer vision python notebooks with the highest performance.

## Features

* All the advantages of docker containers
* NVidia CUDA 9.0 with CUDNN 7 framework
* OpenCV 3.3.1
* Python 3.5
* Julia 0.6.1
* Jupyter notebooks
* Fish shell, tmux and screen
* C/C++, CMake and ninja builder
* Vim with some useful plugins

## Requirements

The minimal requirement is the docker platform.
However, to run computations in GPU you must have a Nvidia CUDA enabled card and install the [Nvidia CUDA docker platform](https://devblogs.nvidia.com/parallelforall/nvidia-docker-gpu-server-application-deployment-made-easy/).
We recomend to customize the docker configuration for a better performance.
In my machine it uses only 2 cores and 2 GB of RAM by default, which is very low for computer vision tasks, so I increased to almost the maximum.

## Deployment

```
docker build -t goldenheart:2.0.0 .
```

If your CPU does not have advanced instructions, as AVX2 and SSE4.2, you must
override these flags in OpenCV. In this case, replace the above command with:

```
docker build --build-arg OPENCV_FLAGS="" -t goldenheart:2.0.0 .
```

## Running Jupyter

You are now able to run this container as usual:

```
docker run --rm -it goldenheart:2.0.0
```

However, to use Jupyter notebooks, you must inform the port forwarding parameter, and run jupyter inside the container:

```
docker run --rm -p 8888:8888 -it goldenheart:2.0.0
jupyter-notebook --ip='*' -p 8888 --no-browser --allow-root
```

Open a browser in the address **http://localhost:8888** aaaand Ta-dah!

We recommend sharing the working directory and to enable instance persistence:
```
docker run --name="science" -v (pwd):/playground/ -p 8888:8888 -it goldenheart:2.0.0
```
which can be restored with:
```
docker start -a science
```

***
This project is updated mainly in the halloween, thanks to the Hacktoberfest event.
But you are free to make sugestions in the issue list or to provide bug fixes by pull requests.

Marry Xmas and see you in the next Hacktoberfest (or sooner)!
