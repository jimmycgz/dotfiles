#!/bin/bash

detect_os () {
# OS/Distro Detection
    # Try lsb_release, fallback with /etc/issue then uname command
    KNOWN_DISTRIBUTION="(Debian|Ubuntu|RedHat|CentOS|openSUSE|Amazon|Arista|SUSE)"
    DISTRIBUTION=$(lsb_release -d 2>/dev/null | grep -Eo $KNOWN_DISTRIBUTION  || grep -Eo $KNOWN_DISTRIBUTION /etc/issue 2>/dev/null || grep -Eo $KNOWN_DISTRIBUTION /etc/Eos-release 2>/dev/null || grep -m1 -Eo $KNOWN_DISTRIBUTION /etc/os-release 2>/dev/null || uname -s)
    export OS=""

    if [ $DISTRIBUTION = "Darwin" ]; then
        OS="MacOS"
    elif [ -f /etc/debian_version -o "$DISTRIBUTION" == "Debian" -o "$DISTRIBUTION" == "Ubuntu" ]; then
        OS="Debian"
    elif [ -f /etc/redhat-release -o "$DISTRIBUTION" == "RedHat" -o "$DISTRIBUTION" == "CentOS" -o "$DISTRIBUTION" == "Amazon" ]; then
        OS="RedHat"
    # Some newer distros like Amazon may not have a redhat-release file
    elif [ -f /etc/system-release -o "$DISTRIBUTION" == "Amazon" ]; then
        OS="RedHat"
    # Arista is based off of Fedora14/18 but do not have /etc/redhat-release
    elif [ -f /etc/Eos-release -o "$DISTRIBUTION" == "Arista" ]; then
        OS="RedHat"
    # openSUSE and SUSE use /etc/SuSE-release
    elif [ -f /etc/SuSE-release -o "$DISTRIBUTION" == "SUSE" -o "$DISTRIBUTION" == "openSUSE" ]; then
        OS="SUSE"
    fi

    echo " OS Type detected: $OS"
}

#Main task
detect_os
# echo "OS Distribution is: $OS"

# Run tasks based on OS distributions
echo " Setting for $OS"

if [ $OS = "MacOS" ]; then
    #./install-scripts/mac-install-scripts.sh
    ./install-scripts/create-symlinks.sh

elif [ $OS = "Debian" ]; then
    # debian_task
    #./install-scripts/ubuntu-install-scripts.sh
    ./install-scripts/create-symlinks.sh

elif  [ $OS = "RedHat" ]; then
    # redhat_centos_task
    #./install-scripts/centos-install-scripts.sh
    ./install-scripts/create-symlinks.sh

elif [ $OS = "SUSE" ]; then
    echo "Do nothing for OS: $OS"
    # sudo zypper install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
fi

# apply the config

echo " "
echo "Please Run below command manually to apply the config"
echo " "

echo "if [ -e $HOME/.zshrc ]; then"
echo "    source $HOME/.zshrc"
echo "elif [ -e $HOME/.bashrc ]; then"
echo "    source $HOME/.bashrc "
echo "fi"

echo " "