#!/bin/bash
set -x
cp -a ~/.vimrc .vimrc
rm -rf .vim
cp -a ~/.vim .
set +x
