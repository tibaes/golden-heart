#!/bin/bash

sed -i s/archive/br.archive/ /etc/apt/sources.list
apt-get update
apt-get install -y aptitude

aptitude update
aptitude install -y wget curl git zip ssh screen ruby python fish

aptitude install -y clang-format vim
wget https://gist.githubusercontent.com/tibaes/92a7255d84bde5f1fd7a/raw/5d9360cbab3e0a25258776eab6d6c2108d0b7f2b/vimrc
mv vimrc ~/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
