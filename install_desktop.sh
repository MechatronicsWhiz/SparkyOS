#!/bin/bash
################ Phase 1: Update and upgrade ################
sudo apt update
sudo apt upgrade -y

################ Phase 2: Install desktop environment ################
sudo apt-get --no-install-recommends install -y lxqt-core gvfs
sudo apt-get install -y openbox lightdm #


################ Phase 3: Install additional packages and configure autologin ################
# Install Thonny
sudo apt-get install -y thonny

# Install Chromium (Chromium is preferred over chromium-browser which may be deprecated in some systems)
sudo apt-get install -y chromium

# Install other required packages
sudo apt-get install -y python3-pyqt5 python3-pyqt5.qtwebengine


# Enable the autologin service
sudo raspi-config nonint do_boot_behaviour B4 # Set lightdm to use autologin
sudo systemctl enable lightdm.service

echo "##################################################################"
echo "########################## Phase 1 done ##########################"
sleep 2
