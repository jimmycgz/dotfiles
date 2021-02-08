#!/bin/bash


# Features:
# Config alias by creating symlinks of dotfile in the home folder for dot file

#==============
# Variables
#==============
dotfiles_dir=$(pwd)/conf-dot-files
#dotfiles_dir=$(pwd)/dotfiles/conf-dot-files

replace_dot_files () {
    
#==============
# Backup existing dot files, replace the existing dot files only
#==============
    export BKP_DOT_FOLDER=$HOME/BKP-dotfiles-$(date "+DATE-%Y-%m-%d")
    mkdir -p $BKP_DOT_FOLDER

    IFS=' '
    OLD_FILES="vim vimrc bashrc zshrc gitconfig tmux tmuxconf bash_aliases bashrc_aliases bash_docker_aliases bashrc_docker_aliases bash_kubectl_aliases bashrc_kubectl_aliases"
    for FILE in $OLD_FILES; do 
        if [ "$FILE" != "" ] && [ ! -L $HOME/.$FILE ] && [ -f $dotfiles_dir/$FILE ]; then
            #-L FILE - True if the FILE exists and is a symbolic link.
            mv $HOME/.$FILE $BKP_DOT_FOLDER > /dev/null 2>&1
            echo " Backed up: .$FILE to folder: $BKP_DOT_FOLDER"
            ln -sf $dotfiles_dir/$FILE $HOME/.$FILE > /dev/null 2>&1
            echo " Linked: $FILE"
        fi
        
    done

    unset IFS
}

add_default_dot_files () {
#==============
# Add docker and k8s dot files
#==============
    echo " "
    IFS=' '
    K8S_FILES="bash_aliases bash_docker_aliases bash_kubectl_aliases"
    for FILE in $K8S_FILES; do 
        if [ "$FILE" != "" ] && [ -f $dotfiles_dir/$FILE ]; then
            ln -sf $dotfiles_dir/$FILE $HOME/.$FILE > /dev/null 2>&1
            echo " Linked: $FILE"
        fi
        
    done

    unset IFS
}

add_vim_plug_in () {
    if [ -f $HOME/.vimrc ] ; then
    mkdir -p $HOME/.vim
    cp $dotfiles_dir/vim/* $HOME/.vim
}

#==============
# Set zsh as the default shell
#==============
# chsh -s /bin/zsh
