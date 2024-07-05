#!/bin/bash
################ Phase 1: Update and upgrade ################
sudo apt update
sudo apt upgrade -y

################ Phase 2: Install desktop environment ################
sudo apt-get --no-install-recommends install -y lxqt-core gvfs
sudo apt-get install -y openbox lightdm #

# Install Thonny and Chrome
sudo apt-get install -y thonny
sudo apt-get install -y chromium

# Auto login
sudo raspi-config nonint do_boot_behaviour B4 # Set lightdm to use autologin
sudo systemctl enable lightdm.service

echo "##################################################################"
echo "########################## Phase 2 done ##########################"
sleep 2


