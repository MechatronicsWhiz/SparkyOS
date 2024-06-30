#!/bin/bash

# Install Xorg and the PIXEL environment
sudo apt install xserver-xorg raspberrypi-ui-mods

# Configure the system to boot to desktop
sudo raspi-config nonint do_boot_behaviour B4

# Optional: Enable Wayland
sudo raspi-config nonint do_boot_behaviour B5

echo "Setup complete! Reboot your Raspberry Pi to start the desktop environment."
