#!/bin/bash

log_file=~/install_progress_log.txt
DEBIAN_FRONTEND=noninteractive

function install_zsh () {
    sudo apt-get -y install zsh
    if type -p zsh > /dev/null; then
        echo "zsh installed" >> $log_file
    else
        echo "zsh failed to install" >> $log_file
    fi
}

function install_vim () {
    sudo apt-get -y install vim-gnome
    if type -p vim > /dev/null; then
        echo "Vim installed" >> $log_file
    else
        echo "Vim failed to install" >> $log_file
    fi
}

function install_curl () {

    sudo apt-get -y install curl
    if type -p curl > /dev/null; then
        echo "curl installed" >> $log_file
    else
        echo "curl failed to install" >> $log_file
    fi
}

function install_silver () {
    sudo apt-get install silversearcher-ag
    if type -p ag > /dev/null; then
        echo "Silver searcher installed" >> $log_file
    else
        echo "Silver searcher failed to install" >> $log_file
    fi
}

function install_tmux () {
    sudo apt-get -y install tmux
    if type -p tmux > /dev/null; then
        echo "sudo doesnot work,trying without sudo " >> $log_file
    else
        apt-get -y install tmux
    fi
    
    if type -p tmux > /dev/null; then
        cp conf-dot-files/tmux.conf $HOME/.tmux.conf
        echo "tmux installed" >> $log_file
    else
        echo "tmux failed to install" >> $log_file
    fi
}

function install_pip () {
    sudo apt-get -y install python-pip
    if type -p pip > /dev/null; then
        echo "pip installed" >> $log_file
    else
        echo "pip failed to install" >> $log_file
    fi
}

function install_venv () {
    pip install virtualenvwrapper
    if pip freeze | grep virtualenvwrapper > /dev/null; then
        echo "virtualenvwrapper installed" >> $log_file
        tmux
    else
        echo "virtualenvwrapper failed to install" >> $log_file
    fi
}


# Start here
sudo apt-get update > /dev/null
install_tmux
#==============
# Give the user a summary of what has been installed
#==============
echo -e "\n====== Summary ======\n"
cat $log_file
echo
rm $log_file
