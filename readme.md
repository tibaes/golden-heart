# Golden Heart

* A container for high performance computer vision.

***

This container focuses on high performance computer vision research.
It was designed targeting the Nvidia CUDA docker platform, so it is based on the Nvidia CUDA 9.1+CUDNN+Centos7 docker image.
Above the CUDA framework we install OpenCV with GPU and CPU optimizations enabled by default.
Also, we install Python3, Julia and Jupyter for running notebooks.
Naturally, OpenCV is compiled with CUDA and python support, so
you can run your computer vision python notebooks with the highest performance.

## Features

* All the advantages of docker containers
* CentOS 7
* NVidia CUDA 9.1 with CUDNN 7 framework
* OpenCV (3.4.1)
* Python (3.6.3)
* Julia (0.6.2)
* C/C++ (clang 4.0.1; g++ 7.3.1)
* CMake (3.11.1)
* Ninja (1.8.2)
* Boost (1.67.0)
* FFMpeg, PNG, JPEG, TIFF, V4L, BLAS, LAPACK...
* Numpy, Scipy, Matplotlib, Pandas, Scikit-Image
* TensorFlow, Keras, SciKit-Learn
* IPython, IJulia, JuliaCxx (C++ inside Julia!)
* Jupyter notebooks
* Fish shell, tmux, screen, git
* Vim with some useful plugins

## Requirements

The minimal requirement is the docker platform.
However, to run computations in GPU you must have a Nvidia CUDA enabled card and install the [Nvidia CUDA docker platform](https://devblogs.nvidia.com/parallelforall/nvidia-docker-gpu-server-application-deployment-made-easy/).

## Deployment

Pull the image from DockerHub:
```
docker pull scieule/goldenheart
```

Or build by yourself:
```
docker build -t goldenheart:latest .
```
Keep in mind that this can take a very long time to build. Building OpenCV with CUDA support alone consumes almost an hour in a high-end desktop.

## Running Jupyter

You are now able to run this container as usual:

```
docker run --rm -it goldenheart
```

However, to use Jupyter notebooks, you must inform the port forwarding parameter, and run jupyter inside the container:

```
docker run --rm -p 8888:8888 -it goldenheart
jupyter-notebook --ip='*' -p 8888 --no-browser --allow-root
```

Open a browser in the address **http://localhost:8888** aaaand Ta-dah!

We recommend sharing the working directory and to enable instance persistence:
```
docker run --name="science" -v (pwd):/playground/ -p 8888:8888 -it goldenheart
```
which can be restored with:
```
docker start -a science
```

***
This project is updated mainly in the halloween, thanks to the Hacktoberfest event.
But you are free to make sugestions in the issue list or to provide bug fixes by pull requests.

Marry Xmas and see you in the next Hacktoberfest (or sooner)!
--
Sooner, yay!