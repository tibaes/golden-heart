FROM nvidia/cuda:9.1-cudnn7-devel-centos7

SHELL ["/bin/bash", "-c"]
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN yum groupinstall -y "Development tools"

RUN yum install -y  wget \
                    unzip \
                    screen tmux \
                    ruby \
                    vim \
                    bc \
                    man \
                    ncurses-devel \
                    zlib-devel \
                    curl-devel \
                    openssl-devel

RUN yum install -y qt5*devel gtk2-devel

RUN yum install -y  blas-devel \
                    lapack-devel \
                    atlas-devel \
                    gcc-gfortran \
                    tbb-devel \
                    eigen3-devel \
                    jasper-devel \
                    libpng-devel \
                    libtiff-devel \
                    openexr-devel \
                    libwebp-devel \
                    libv4l-devel \
                    libdc1394-devel \
                    libv4l-devel \
                    gstreamer-plugins-base-devel

# C/C++ CMake Python

RUN yum install -y  centos-release-scl && \
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

# CMake

ARG CMAKE_VERSION="3.11.1"
RUN cd /root && wget https://cmake.org/files/v3.11/cmake-${CMAKE_VERSION}.tar.gz && tar xzf cmake-${CMAKE_VERSION}.tar.gz
RUN source /etc/bashrc && cd /root/cmake-${CMAKE_VERSION}} && \
        ./bootstrap --system-curl --parallel=4 --prefix=/usr &&
        gmake

# Ninja

ARG NINJA_VERSION="1.8.2"
RUN cd /root && wget https://github.com/ninja-build/ninja/releases/download/v${NINJA_VERSION}/ninja-linux.zip
RUN cd /root && unzip ninja-linux.zip && mv ninja /usr/local/bin/

# Fish

ARG FISH_VERSION="2.7.1-1.1"
RUN wget https://download.opensuse.org/repositories/shells:/fish:/release:/2/CentOS_7/x86_64/fish-${FISH_VERSION}.x86_64.rpm
RUN cd /root && rpm -i fish-${FISH_VERSION}.x86_64.rpm

# Python libs & jupyter

RUN source /etc/bashrc; pip3 install --upgrade pip
RUN source /etc/bashrc; pip3 install numpy scipy matplotlib pandas \
                                    tensorflow-gpu keras \
                                    scikit-image scikit-learn \
                                    jsonschema jinja2 tornado pyzmq ipython jupyter

# OpenCV

ARG OPENCV_VERSION="3.4.1"
RUN cd /root && wget -O opencv.zip https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip
RUN cd /root && wget -O contrib.zip https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip
RUN cd /root && unzip opencv.zip && unzip contrib.zip
RUN source /etc/bashrc; mkdir /root/opencv-$OPENCV_VERSION/build && cd /root/opencv-$OPENCV_VERSION/build && \
    /usr/local/bin/cmake .. -G"Ninja" -DCMAKE_BUILD_TYPE=RELEASE \
    -DENABLE_CXX11=ON -DOPENCV_ENABLE_NONFREE=ON -DCUDA_HOST_COMPILER=/usr/bin/g++ \
    -DOPENCV_EXTRA_MODULES_PATH=/root/opencv_contrib-$OPENCV_VERSION/modules \
    -DPYTHON_EXECUTABLE=$(which python3) && \
    ninja && ninja install
RUN cp /root/opencv-$OPENCV_VERSION/build/lib/python3/cv2.cpython-35m-x86_64-linux-gnu.so /usr/local/lib/python3.5/dist-packages/
# /opt/rh/rh-python36/root/lib/python3.6/site-packages/

# Julia

ARG JULIA_URL="https://julialang-s3.julialang.org/bin/linux/x64/0.6/julia-0.6.2-linux-x86_64.tar.gz"
ARG JULIA_PATH="julia-d386e40c17"
RUN cd /root && wget -O julia.tar.gz ${JULIA_URL} && tar xzf julia.tar.gz
RUN mv /root/$JULIA_PATH/ /opt/julia && chown -R root.root /opt/julia && chmod -R +rx /opt/julia
RUN ln -s /opt/julia/bin/julia /usr/local/bin/julia
RUN source /etc/bashrc; julia -e 'Pkg.update()'
RUN source /etc/bashrc; julia -e 'Pkg.add("IJulia")'

# # Finnaly

RUN rm -rf /tmp/*.rpm /root/*opencv* /root/*julia* /root/*cmake* /root/*ninja*

# # Vim Configuration

# COPY vimrc /root/.vimrc
# RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# RUN echo -e "Run inside vim\n:PlugInstall"


RUN mkdir /playground
WORKDIR /playground

CMD fish
EXPOSE 8888
