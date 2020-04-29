#!/bin/bash
BACKUP_DIR=backup_$(date +%F-%H%M%S)
set -x
mkdir $BACKUP_DIR
mv ~/.vim $BACKUP_DIR/.vim
mv ~/.vimrc $BACKUP_DIR/.vimrc

cp -a .vimrc ~/.vimrc
cp -a .vim ~/.vim
set +x
