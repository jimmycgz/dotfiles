#!/bin/bash


# Features:
# Config alias by creating symlinks of dotfile in the home folder for dot file

#==============
# Variables
#==============
dotfiles_dir=$(PWD)/conf-dot-files

#==============
# Backup existing dot files and folders
#==============
export BKP_DOT_FOLDER=$HOME/BKP-dotfiles-$(date "+DATE-%Y-%m-%d")
mkdir -p $BKP_DOT_FOLDER

IFS=' '
OLD_FILES="vim vimrc bashrc zshrc gitconfig tmux tmuxconf bash_aliases bashrc_aliases bash_docker_aliases bashrc_docker_aliases bash_kubectl_aliases bashrc_kubectl_aliases"
for FILE in $OLD_FILES; do 
    if [ -e $HOME/.$FILE ]; then
        mv $HOME/.$FILE $BKP_DOT_FOLDER > /dev/null 2>&1
        ln -sf $dotfiles_dir/$FILE $HOME/.$FILE > /dev/null 2>&1
    fi
    
done

unset IFS


echo " "
echo " Below legacy dot files are moved to folder: $BKP_DOT_FOLDER"
ls -a $BKP_DOT_FOLDER


#==============
# Set zsh as the default shell
#==============
# chsh -s /bin/zsh
