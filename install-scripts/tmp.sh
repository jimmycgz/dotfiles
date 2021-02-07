#!/bin/bash

IFS=' '
OLD_FILES=".vim .vimrc .bashrc"
for OLD_FILE in $OLD_FILES; do echo $OLD_FILE;echo " ";done
unset IFS