#!/bin/bash
BACKUP_DIR=backup_$(date +%F-%H%M%S)
set -x
mkdir $BACKUP_DIR
cp -a ~/.vim $BACKUP_DIR/.vim
cp -a ~/.vimrc $BACKUP_DIR/.vimrc

cp -a .vimrc ~/.vimrc
cp -a .vim ~/.vim
set +x
