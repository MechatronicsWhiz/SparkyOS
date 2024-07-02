#!/bin/bash

# Update package list and install lxqt-core with minimal dependencies
sudo apt update
sudo apt upgrade -y

# Install display manager
sudo apt-get --no-install-recommends install -y lxqt-core 
sudo apt-get install -y lightdm

# Configure LightDM to use LXQt as the default session
sudo sed -i 's/^#user-session=.*/user-session=lxqt/' /etc/lightdm/lightdm.conf

# Enable the autologin service
sudo raspi-config nonint do_boot_behaviour B4 # autologin
sudo systemctl enable lightdm.service

echo "#################################### Stage 1 done ####################################"


