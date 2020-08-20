#!/bin/bash
set -x
cp -a ~/.vimrc .vimrc
rm -rf .vim
mkdir .vim
cp -a ~/.vim/plugin .vim/
set +x
