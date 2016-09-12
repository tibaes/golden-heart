FROM nvidia/cuda:8.0
MAINTAINER r@fael.nl

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ARG OPENCV_VERSION="3.1.0"
ARG DLIB_VERSION="19.1"

# Core

RUN apt-get update && apt-get install -y --no-install-recommends aptitude

RUN aptitude update && aptitude install -y wget curl git \
  zip bzip2 ca-certificates locales ssh screen tmux ruby python fish

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# C++

RUN aptitude update && aptitude install -y build-essential cmake cmake-curses-gui ninja-build pkg-config
RUN aptitude update && aptitude install -y libx11-dev libopenblas-dev liblapack-dev libgtk2.0-dev

# OpenCV

RUN wget https://github.com/Itseez/opencv/archive/$OPENCV_VERSION.zip
RUN unzip $OPENCV_VERSION.zip
RUN git clone https://github.com/Itseez/opencv_contrib.git
RUN mkdir opencv-$OPENCV_VERSION/build
RUN cd opencv-$OPENCV_VERSION/build && \
  cmake .. -G"Ninja" -DCMAKE_BUILD_TYPE=RELEASE -DENABLE_AVX2=ON -DENABLE_SSE42=ON && \
  ninja && ninja install
RUN rm -rf $OPENCV_VERSION.zip opencv-$OPENCV_VERSION

# DLib

RUN wget http://dlib.net/files/dlib-$DLIB_VERSION.tar.bz2
RUN tar xjf dlib-$DLIB_VERSION.tar.bz2
RUN mkdir dlib-$DLIB_VERSION/build
RUN cd dlib-$DLIB_VERSION/build && \
  cmake .. -G"Ninja" -DCMAKE_BUILD_TYPE=RELEASE && \
  ninja && ninja install
RUN rm -rf dlib-$DLIB_VERSION.tar.bz2 dlib-$DLIB_VERSION

# Vim

RUN aptitude update && aptitude install -y clang-format vim
RUN wget https://gist.githubusercontent.com/tibaes/92a7255d84bde5f1fd7a/raw/3227f504289a4b31388d8297fce6e40b7ee88f5b/vimrc
RUN mv vimrc ~/.vimrc
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Jupyter (Python3 & Julia4)

RUN aptitude update && aptitude install -y libmagickwand-6.q16-2 python3 python3-dev python3-pip julia
RUN pip3 install --upgrade pip
RUN pip3 install jsonschema jinja2 tornado pyzmq ipython jupyter

RUN julia -e 'Pkg.add("Images")'
RUN julia -e 'Pkg.add("ImageMagick")'
RUN julia -e 'Pkg.add("IJulia")'
RUN julia -e 'Pkg.build("IJulia")'

# Finnaly

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /root/.jupyter
COPY jupyter_notebook_config.py /root/.jupyter/
COPY mycert.pem /root/
COPY mykey.key /root/

RUN mkdir /playground
WORKDIR /playground

EXPOSE 9999
CMD = fish
