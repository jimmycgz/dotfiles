log_file=~/install_progress_log.txt

apt-get -y install zsh
if type -p zsh > /dev/null; then
    echo "zsh Installed" >> $log_file
else
    echo "zsh FAILED TO INSTALL!!!" >> $log_file
fi

apt-get -y install vim-gnome
if type -p vim > /dev/null; then
    echo "Vim Installed" >> $log_file
else
    echo "Vim FAILED TO INSTALL!!!" >> $log_file
fi

apt-get -y install curl
if type -p curl > /dev/null; then
    echo "curl Installed" >> $log_file
else
    echo "crul FAILED TO INSTALL!!!" >> $log_file
fi

apt-get install silversearcher-ag
if type -p ag > /dev/null; then
    echo "Silver searcher Installed" >> $log_file
else
    echo "Silver searcher FAILED TO INSTALL!!!" >> $log_file
fi

apt-get -y install tmux
if type -p tmux > /dev/null; then
    echo "tmux Installed" >> $log_file
else
    echo "tmux FAILED TO INSTALL!!!" >> $log_file
fi

apt-get -y install python-pip
if type -p pip > /dev/null; then
    echo "pip Installed" >> $log_file
else
    echo "pip FAILED TO INSTALL!!!" >> $log_file
fi

pip install virtualenvwrapper
if pip freeze | grep virtualenvwrapper > /dev/null; then
    echo "virtualenvwrapper Installed" >> $log_file
else
    echo "virtualenvwrapper FAILED TO INSTALL!!!" >> $log_file
fi

#==============
# Give the user a summary of what has been installed
#==============
echo -e "\n====== Summary ======\n"
cat $log_file
echo
rm $log_file