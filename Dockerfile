from ubuntu:wily
maintainer hi@fael.nl

# build
run sed -i s/archive/br.archive/ /etc/apt/sources.list
run apt-get update && apt-get install -y aptitude build-essential cmake ninja pkg-config
run apt-get update && apt-get install -y wget curl git zip 
run apt-get update && apt-get install -y julia ruby python fish

# vim
run apt-get update && apt-get install -y clang-format-3.7 vim && \
  cd ~ && git clone https://gist.github.com/92a7255d84bde5f1fd7a.git && \
  mv 92a7255d84bde5f1fd7a/vimrc ~/.vimrc && rm -rf 92a7255d84bde5f1fd7a/ && \
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#TODO: CUDA
#TODO: OpenNI

# opencv
run cd ~ && wget https://github.com/Itseez/opencv/archive/3.0.0.zip && unzip 3.0.0.zip && \
  git clone https://github.com/Itseez/opencv_contrib.git && \
  mkdir ~/opencv-3.0.0/build && cd ~/opencv-3.0.0/build && \
  cmake .. -DCMAKE_BUILD_TYPE=RELEASE -DENABLE_AVX2=ON -DENABLE_SSE42=ON && \
  make -j6 && make install
#TODO: brew + TBB + Contrib
# cmake .. -DCMAKE_BUILD_TYPE=RELEASE -DENABLE_AVX2=ON -DENABLE_SSE42=ON -DWITH_TBB=ON -DBUILD_TBB=ON -DOPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules/ && \

# dlib
run cd ~ && wget http://dlib.net/files/dlib-18.18.tar.bz2 && \
  tar xjf dlib-18.18.tar.bz2

# ijulia

# openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mykey.key -out mycert.pem 
# copy some .pub key
