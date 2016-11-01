FROM nvidia/cuda:8.0
MAINTAINER r@fael.nl

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ARG OPENCV_VERSION="3.1.0"
ARG DLIB_VERSION="19.1"
ARG CUDNN_RUNTIME="libcudnn5_5.1.5-1+cuda8.0_amd64.deb"
ARG CUDNN_DEVELOP="libcudnn5-dev_5.1.5-1+cuda8.0_amd64.deb"
ARG JULIA="julia-0.4.6-linux-x86_64.tar.gz"
ARG JULIA_PATH="julia-2e358ce975"
ARG OPENCV_FLAGS="-DENABLE_AVX2=ON -DENABLE_SSE42=ON"

# Core

RUN apt-get update && apt-get install -y --no-install-recommends aptitude

RUN aptitude update && aptitude install -y wget curl git \
  zip bzip2 ca-certificates locales ssh screen tmux ruby python fish

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# C++, Python3, Jupyter - OpenCV & DLib deps

RUN aptitude update && aptitude install -y build-essential cmake cmake-curses-gui ninja-build pkg-config
RUN aptitude update && aptitude install -y libx11-dev libgtk2.0-dev
RUN aptitude update && aptitude install -y libopenblas-dev liblapack-dev libatlas-base-dev gfortran libtbb-dev
RUN aptitude update && aptitude install -y libjasper-dev  libjpeg-dev libpng-dev libtiff-dev
RUN aptitude update && aptitude install -y libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libv4l-dev
RUN aptitude update && aptitude install -y python3 python3-dev python3-pip python3-numpy python3-scipy libboost-python-dev
RUN aptitude update && aptitude install -y clang-format-3.8 vim

RUN pip3 install --upgrade pip
RUN pip3 install jsonschema jinja2 tornado pyzmq ipython jupyter

# CuDNN

COPY archive/$CUDNN_RUNTIME /root/$CUDNN_RUNTIME
COPY archive/$CUDNN_DEVELOP /root/$CUDNN_DEVELOP
RUN dpkg -i /root/$CUDNN_RUNTIME
RUN dpkg -i /root/$CUDNN_DEVELOP

# OpenCV

COPY archive/$OPENCV_VERSION.zip /root
COPY opencv_cuda8.patch /root
RUN cd /root && unzip $OPENCV_VERSION.zip
RUN cd /root/opencv-$OPENCV_VERSION/modules/cudalegacy/src/ && patch < /root/opencv_cuda8.patch
RUN mkdir /root/opencv-$OPENCV_VERSION/build && cd /root/opencv-$OPENCV_VERSION/build && \
  cmake .. -G"Ninja" -DCMAKE_BUILD_TYPE=RELEASE $OPENCV_FLAGS -DPYTHON_EXECUTABLE=$(which python3) -DINSTALL_PYTHON_EXAMPLES=ON && \
  ninja && ninja install
RUN cp /root/opencv-$OPENCV_VERSION/build/lib/python3/cv2.cpython-34m.so /usr/local/lib/python3.4/dist-packages/

# DLib

COPY archive/dlib-$DLIB_VERSION.tar.bz2 /root
RUN cd /root && tar xjf dlib-$DLIB_VERSION.tar.bz2
RUN mkdir /root/dlib-$DLIB_VERSION/build && cd /root/dlib-$DLIB_VERSION/build && \
  cmake .. -G"Ninja" -DCMAKE_BUILD_TYPE=RELEASE && \
  ninja && ninja install

# Julia

COPY archive/$JULIA /root
RUN cd /root && tar xzf $JULIA
RUN ln -s /root/$JULIA_PATH/bin/julia /usr/local/bin/julia
RUN julia -e 'Pkg.update()'
RUN julia -e 'Pkg.add("IJulia")'

# Jupyter Configuration

RUN mkdir /root/.jupyter
COPY jupyter_notebook_config.py /root/.jupyter/
COPY mycert.pem /root/
COPY mykey.key /root/

# Vim Configuration

COPY vimrc /root/.vimrc
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN echo -e "Run inside vim\n:PlugInstall"

# Finnaly

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /playground
WORKDIR /playground

CMD fish
EXPOSE 9999
