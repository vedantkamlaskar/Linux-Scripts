#!/bin/bash
#title           :firewall.sh
#description     :This script will install UFW and set up firewall rules.
#author		 	 :Vedant
#date            :12th November 2018
#version         :1.0
#usage		 	 :bash firewall.sh
#bash_version    :GNU bash, version 4.3.48(1)-release 
#==============================================================================
App="ufw"    
echo "Today's date is: $(date)"
sleep 2
echo "Installation of UFW will now begin"
echo "Input the root password in the next step"

for pkg in $App; do
    if dpkg --get-selections | grep -q "^$pkg[[:space:]]*install$" >/dev/null; then
        echo -e "$pkg is already installed"
    else
        sudo apt-get -qq install $pkg
        echo "Successfully installed $pkg"
    fi
done

echo "Setting rules: "
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow in on eth0 from 10.10.3.2 to any port 8193
sudo ufw allow in on wlan0 from 10.42.0.0/24 to any port 8888
sudo ufw status verbose
sudo ufw enable
echo "Following rules added to firewall"
sudo ufw status verbose
echo "Rules added"
echo "Exiting .."
sleep 3s
exit
