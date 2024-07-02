#!/bin/bash

# Update package list and upgrade installed packages
sudo apt update
sudo apt upgrade -y

# Install LXQt core with minimal dependencies and LightDM display manager
sudo apt-get --no-install-recommends install -y lxqt-core
sudo apt-get install -y lightdm

# Enable the autologin service
sudo raspi-config nonint do_boot_behaviour B4 # autologin
sudo systemctl enable lightdm.service

# Install Sway and necessary tools
sudo apt install -y sway

# Create Sway configuration directory and copy example configuration
mkdir -p ~/.config/sway
cp /etc/sway/config ~/.config/sway/config

# Create a startup script for Sway
cat <<EOL > ~/.config/sway/start.sh
#!/bin/bash
sway
EOL

# Make the startup script executable
chmod +x ~/.config/sway/start.sh

# Provide instructions to start Sway
echo "To start Sway, run ~/.config/sway/start.sh"

# Reboot to apply changes
echo "#################################### Stage 1 done ####################################"
sudo reboot
