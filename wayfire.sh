#!/bin/bash

# Update package list
sudo apt update

# Install dependencies for building Wayfire
sudo apt install -y git meson ninja-build pkg-config libwayland-dev \
libegl1-mesa-dev libgles2-mesa-dev libgbm-dev

# Clone Wayfire repository
git clone https://github.com/WayfireWM/wayfire.git
cd wayfire

# Build and install Wayfire
meson build
cd build
ninja
sudo ninja install

# Install LightDM
sudo apt install -y lightdm

# Configure LightDM for Wayfire session
echo "[Seat:*]" | sudo tee -a /etc/lightdm/lightdm.conf > /dev/null
echo "user-session=wayfire" | sudo tee -a /etc/lightdm/lightdm.conf > /dev/null

# Create Wayfire session desktop file
sudo tee /usr/share/xsessions/wayfire.desktop > /dev/null <<EOL
[Desktop Entry]
Name=Wayfire
Comment=Wayland compositor
Exec=wayfire
TryExec=wayfire
Type=Application
EOL

# Restart LightDM
sudo systemctl restart lightdm

echo "Installation and configuration completed."
echo "Please reboot your Raspberry Pi to start using Wayfire with LightDM."
