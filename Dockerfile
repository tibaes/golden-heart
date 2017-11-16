FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
MAINTAINER r@fael.nl

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Core

RUN apt-get update && apt-get install -y --no-install-recommends aptitude

RUN aptitude update && aptitude install -y wget curl git \
  zip bzip2 ca-certificates locales ssh screen tmux ruby python fish

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

RUN aptitude update && aptitude install -y build-essential cmake cmake-curses-gui ninja-build pkg-config
RUN aptitude update && aptitude install -y libx11-dev libgtk2.0-dev
RUN aptitude update && aptitude install -y libopenblas-dev liblapack-dev libatlas-base-dev gfortran libtbb-dev
RUN aptitude update && aptitude install -y libjasper-dev  libjpeg-dev libpng-dev libtiff-dev
RUN aptitude update && aptitude install -y libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libv4l-dev
RUN aptitude update && aptitude install -y python3 python3-dev python3-pip python3-numpy python3-scipy libboost-python-dev
RUN aptitude update && aptitude install -y clang-format-3.8 vim

# Jupyter

RUN pip3 install --upgrade pip
RUN pip3 install jsonschema jinja2 tornado pyzmq ipython jupyter

# OpenCV

ARG OPENCV_VERSION="3.3.1"
ARG OPENCV_FLAGS="-DENABLE_AVX2=ON -DENABLE_SSE42=ON"
RUN cd /root && wget -O opencv.zip https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip
RUN cd /root && wget -O contrib.zip https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip
RUN cd /root && unzip opencv.zip && unzip contrib.zip
RUN mkdir /root/opencv-$OPENCV_VERSION/build && cd /root/opencv-$OPENCV_VERSION/build && \
    cmake .. -G"Ninja" -DCMAKE_BUILD_TYPE=RELEASE $OPENCV_FLAGS \
    -DOPENCV_EXTRA_MODULES_PATH=/root/opencv_contrib-$OPENCV_VERSION/modules \
    -DPYTHON_EXECUTABLE=$(which python3) -DINSTALL_PYTHON_EXAMPLES=ON && \
    ninja && ninja install
RUN cp /root/opencv-$OPENCV_VERSION/build/lib/python3/cv2.cpython-35m-x86_64-linux-gnu.so /usr/local/lib/python3.5/dist-packages/

# Julia

RUN cd /root && wget https://julialang-s3.julialang.org/bin/linux/x64/0.6/julia-0.6.1-linux-x86_64.tar.gz
ARG JULIA_PACK="julia-0.6.1-linux-x86_64.tar.gz"
ARG JULIA_PATH="julia-0d7248e2ff"
RUN cd /root && tar xzf $JULIA_PACK
RUN ln -s /root/$JULIA_PATH/bin/julia /usr/local/bin/julia
RUN chmod +rx /root/$JULIA_PATH/*
RUN julia -e 'Pkg.update()'
RUN julia -e 'Pkg.add("IJulia")'

# Vim Configuration

COPY vimrc /root/.vimrc
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN echo -e "Run inside vim\n:PlugInstall"

# Finnaly

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /playground
WORKDIR /playground

CMD fish
EXPOSE 8888
