#!/bin/bash
################ Phase 1: Update and upgrade ################
sudo apt-get update
sudo apt-get upgrade -y

################ Phase 2: Install desktop environment ################
sudo apt-get --no-install-recommends install -y lxqt-core gvfs
sudo apt-get install -y openbox lightdm #


# Enable the autologin service
sudo raspi-config nonint do_boot_behaviour B4 # Set lightdm to use autologin
sudo systemctl enable lightdm.service

echo "##################################################################"
echo "########################## Phase 1 done ##########################"
sleep 2
