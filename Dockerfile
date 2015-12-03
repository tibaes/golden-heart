from ubuntu:wily
maintainer hi@fael.nl

# build 
run sed -i s/archive/br.archive/ /etc/apt/sources.list
run apt-get update && apt-get install -y apt-utils aptitude build-essential cmake wget curl git ruby python fish

# vim
run apt-get update && apt-get install -y clang-format-3.7 vim && \
  wget https://gist.githubusercontent.com/tibaes/92a7255d84bde5f1fd7a/raw/af136282d61ca3c2fc2155c611c6cb5cbe54bf55/vimrc && \
  mv vimrc ~/.vimrc && \
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# opencv


# dlib

# ijulia

# openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mykey.key -out mycert.pem 
# copy some .pub key
