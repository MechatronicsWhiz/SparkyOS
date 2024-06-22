#!/bin/bash

# Update package lists
sudo apt update
sudo apt upgrade -y

# Install LXQt, GVFS (without recommended packages)
sudo apt --no-install-recommends install lxqt-core gvfs -y
sudo reboot
# Install Openbox, LightDM 
sudo apt openbox lightdm -y
sudo reboot

# Install additional packages
sudo apt install chromium-browser thonny python3-pyqt5 python3-pyqt5.qtwebengine -y

# Configure autologin for the 'pi' user
sudo raspi-config nonint do_boot_behaviour B4
# Reboot to apply final changes
sudo reboot
