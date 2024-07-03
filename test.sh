#!/bin/bash

# Update and upgrade packages
sudo apt update
sudo apt upgrade -y

# Install LXQt, GVFS, Sway, and LightDM
sudo apt-get --no-install-recommends install -y lxqt-core gvfs sway lightdm

# Determine current username
CURRENT_USER=$(whoami)

# Configure LightDM for automatic login with the current username
sudo tee /etc/lightdm/lightdm.conf.d/autologin.conf > /dev/null <<EOF
[Seat:*]
autologin-user=$CURRENT_USER
autologin-session=sway
EOF

# Reboot to apply changes
sudo reboot
