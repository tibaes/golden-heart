FROM ubuntu:wily
MAINTAINER hi@fael.nl

# build
RUN sed -i s/archive/br.archive/ /etc/apt/sources.list
RUN apt-get update && apt-get install -y aptitude build-essential cmake ninja pkg-config
RUN apt-get update && apt-get install -y wget curl git zip 
RUN apt-get update && apt-get install -y julia ruby python fish

# vim
RUN apt-get update && apt-get install -y clang-format-3.7 vim && \
  cd ~ && git clone https://gist.github.com/92a7255d84bde5f1fd7a.git && \
  mv 92a7255d84bde5f1fd7a/vimrc ~/.vimrc && rm -rf 92a7255d84bde5f1fd7a/ && \
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# opencv
RUN cd ~ && wget https://github.com/Itseez/opencv/archive/3.0.0.zip && unzip 3.0.0.zip && \
  git clone https://github.com/Itseez/opencv_contrib.git && \
  mkdir ~/opencv-3.0.0/build && cd ~/opencv-3.0.0/build && \
  cmake .. -DCMAKE_BUILD_TYPE=RELEASE -DENABLE_AVX2=ON -DENABLE_SSE42=ON && \
  make -j6 && make install

# dlib
RUN cd ~ && wget http://dlib.net/files/dlib-18.18.tar.bz2 && \
  tar xjf dlib-18.18.tar.bz2

# ijulia
RUN cd ~ && apt-get update && apt-get install -y python-pip python-dev build-essential libmagickwand-6.q16-2 && \
  pip install --upgrade pip && pip install jsonschema jinja2 tornado pyzmq ipython jupyter

RUN julia -e 'Pkg.add("IJulia")'
RUN julia -e 'Pkg.add("Images")'

COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
COPY mycert.pem /root/mycert.pem
COPY mykey.key /root/mykey.key

# Add Tini, which operates as a process subreaper for jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT /usr/bin/tini --

EXPOSE 9999
CMD jupyter notebook --no-browser --certfile=/root/mycert.pem --keyfile=/root/mykey.key

# ssh 
RUN apt-get update && apt-get install -y ssh screen
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22

