#!/bin/bash


# Features:
# Config alias by creating symlinks of dotfile in the home folder for dot file

#==============
# Variables
#==============
dotfiles_dir=$(pwd)/conf-dot-files
#dotfiles_dir=$(pwd)/dotfiles/conf-dot-files

#==============
# Backup existing dot files, replace the existing dot files only
#==============
export BKP_DOT_FOLDER=$HOME/BKP-dotfiles-$(date "+DATE-%Y-%m-%d")
mkdir -p $BKP_DOT_FOLDER

IFS=' '
OLD_FILES="vim vimrc bashrc zshrc gitconfig tmux tmuxconf bash_aliases bashrc_aliases bash_docker_aliases bashrc_docker_aliases bash_kubectl_aliases bashrc_kubectl_aliases"
for FILE in $OLD_FILES; do 
    if [ -e $HOME/.$FILE && $dotfiles_dir/$FILE ]; then
        mv $HOME/.$FILE $BKP_DOT_FOLDER > /dev/null 2>&1
        ln -sf $dotfiles_dir/$FILE $HOME/.$FILE > /dev/null 2>&1
    fi
    
done

unset IFS


echo " "
echo " Below legacy dot files are moved to folder: $BKP_DOT_FOLDER"
ls -a $BKP_DOT_FOLDER

#==============
# Add docker and k8s dot files
#==============
echo " "
IFS=' '
K8S_FILES="bash_aliases bash_docker_aliases bash_kubectl_aliases"
for FILE in $K8S_FILES; do 
    if [ -e $dotfiles_dir/$FILE ]; then
        ln -sf $dotfiles_dir/$FILE $HOME/.$FILE > /dev/null 2>&1
        echo "Linked: $FILE"
    fi
    
done

unset IFS


#==============
# Set zsh as the default shell
#==============
# chsh -s /bin/zsh
