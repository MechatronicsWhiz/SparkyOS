#!/bin/bash

# Update and upgrade packages
sudo apt update
sudo apt upgrade -y

# Install LXQt, GVFS, Sway, and LightDM
sudo apt-get --no-install-recommends install -y lxqt-core gvfs
sudo apt-get install -y lightdm sway

# Enable the autologin service
sudo raspi-config nonint do_boot_behaviour B4 # Set lightdm to use autologin
sudo systemctl enable lightdm.service

# Determine current username
CURRENT_USER=$(whoami)

# Edit LightDM configuration for autologin
sudo bash -c "cat <<EOF >/etc/lightdm/lightdm.conf
[Seat:*]
autologin-user=$CURRENT_USER
autologin-session=sway
EOF"

# Reboot to apply changes
sudo reboot
