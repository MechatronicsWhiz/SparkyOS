#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Update package list
sudo apt update

# Install dependencies for building Wayfire
sudo apt install -y git meson ninja-build pkg-config libwayland-dev \
libegl1-mesa-dev libgles2-mesa-dev libgbm-dev || { echo "Failed to install dependencies"; exit 1; }

# Clone Wayfire repository
git clone --depth=1 https://github.com/WayfireWM/wayfire.git
cd wayfire

# Build and install Wayfire
meson build || { echo "Meson build setup failed"; exit 1; }
cd build
ninja || { echo "Ninja build failed"; exit 1; }
sudo ninja install || { echo "Ninja install failed"; exit 1; }

# Install LightDM
sudo apt install -y lightdm || { echo "Failed to install LightDM"; exit 1; }

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
sudo systemctl restart lightdm || { echo "Failed to restart LightDM"; exit 1; }

echo "Installation and configuration completed."
echo "Please reboot your Raspberry Pi to start using Wayfire with LightDM."
