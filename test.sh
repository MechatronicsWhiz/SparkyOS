#!/bin/bash

# Update and upgrade packages
sudo apt update
sudo apt upgrade -y

# Install LXQt, GVFS, Sway, and LightDM
sudo apt-get --no-install-recommends install -y lxqt-core gvfs sway lightdm

# Determine current username
CURRENT_USER=$(whoami)

# Configure LightDM for automatic login with the current username
# Enable the autologin service
sudo raspi-config nonint do_boot_behaviour B4 # Set lightdm to use autologin
sudo systemctl enable lightdm.service

[Seat:*]
autologin-user=$CURRENT_USER
autologin-session=sway
EOF

# Reboot to apply changes
sudo reboot
