FROM nvidia/cuda:9.1-cudnn7-devel-centos7
MAINTAINER r@fael.nl

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN yum update
RUN yum install -y  wget \
                    unzip \
                    screen tmux \
                    ruby \
                    vim

# C/C++ CMake Python

RUN RUN yum install -y  centos-release-scl && \
        yum install -y  devtoolset-7-gcc* \
                        devtoolset-7-valgrind \
                        devtoolset-7-gdb \
                        devtoolset-7-elfutils \
                        clang \
                        llvm-toolset-7 \
                        llvm-toolset-7-cmake \
                        rh-python36-python-pip \
                        rh-git29-git \
                        devtoolset-7-make

RUN echo "source scl_source enable devtoolset-7" >> /etc/bashrc
RUN echo "source scl_source enable llvm-toolset-7" >> /etc/bashrc
RUN echo "source scl_source enable rh-python36" >> /etc/bashrc
RUN echo "source scl_source enable rh-git29" >> /etc/bashrc

RUN yum install -y qt5*devel

# Sci Libs

RUN yum install -y  blas-devel \
                    lapack-devel \
                    atlas-devel \
                    gcc-gfortran \
                    tbb-devel \
                    jasper-devel \
                    libpng-devel \
                    libtiff-devel \
                    libv4l-devel

# libx11-dev libgtk2.0-dev
# libavcodec-dev libavutil-dev libavformat-dev libswscale-dev
# libboost-python-dev

# Ninja builder

RUN cd /tmp/ && wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
   rpm -ivh epel-release-latest-7.noarch.rpm \
RUN yum -y --enablerepo=epel install ninja-build && \
   echo "alias ninja='ninja-build'" >> /etc/bashrc

# Fish

RUN cd /etc/yum.repos.d/ && wget https://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo 
RUN yum install fish -y

# Python libs & jupyter

RUN pip3 install --upgrade pip
RUN pip3 install numpy scipy matplotlib
RUN pip3 install jsonschema jinja2 tornado pyzmq ipython jupyter
# pandas, tensorflow, keras

# OpenCV

ARG OPENCV_VERSION="3.4.1"
RUN cd /root && wget -O opencv.zip https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip
RUN cd /root && wget -O contrib.zip https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip
RUN cd /root && unzip opencv.zip && unzip contrib.zip
RUN mkdir /root/opencv-$OPENCV_VERSION/build && cd /root/opencv-$OPENCV_VERSION/build && \
    cmake .. -G"Ninja" -DCMAKE_BUILD_TYPE=RELEASE \
    -DENABLE_CXX11=ON -DOPENCV_ENABLE_NONFREE=ON -DWITH_TBB=ON\
    -DOPENCV_EXTRA_MODULES_PATH=/root/opencv_contrib-$OPENCV_VERSION/modules \
    -DPYTHON_EXECUTABLE=$(which python3) && \
    ninja && ninja install
RUN cp /root/opencv-$OPENCV_VERSION/build/lib/python3/cv2.cpython-35m-x86_64-linux-gnu.so /usr/local/lib/python3.5/dist-packages/
# cuda_host = /usr/bin/g++

# Julia

ARG JULIA_URL="https://julialang-s3.julialang.org/bin/linux/x64/0.6/julia-0.6.1-linux-x86_64.tar.gz"
ARG JULIA_PATH="julia-0d7248e2ff"
RUN cd /root && wget -O julia.tar.gz ${JULIA_URL} && tar xzf julia.tar.gz
# mv /root/julia... /opt/...
RUN ln -s /root/$JULIA_PATH/bin/julia /usr/local/bin/julia
RUN chmod +rx /root/$JULIA_PATH/*
RUN julia -e 'Pkg.update()'
RUN julia -e 'Pkg.add("IJulia")'

# # Finnaly

RUN rm -rf /tmp/*.rpm /root/*opencv* /root/*julia*

# # Vim Configuration

# COPY vimrc /root/.vimrc
# RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# RUN echo -e "Run inside vim\n:PlugInstall"


RUN mkdir /playground
WORKDIR /playground

CMD fish
EXPOSE 8888
