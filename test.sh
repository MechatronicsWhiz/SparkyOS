#!/bin/bash

# Update package list and upgrade installed packages
sudo apt update
sudo apt upgrade -y

# Install LXQt core with minimal dependencies and LightDM display manager
sudo apt-get --no-install-recommends install -y lxqt-core
sudo apt-get install lightdm -y

# Enable the autologin service in LightDM
sudo raspi-config nonint do_boot_behaviour B4 # autologin
sudo systemctl enable lightdm.service

# Install Sway and necessary tools
sudo apt install sway -y

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

# Configure LightDM to start Sway automatically
sudo tee -a /etc/lightdm/lightdm.conf > /dev/null <<EOL
[Seat:*]
autologin-user=sparky
autologin-session=sway
EOL

# Reboot to apply changes
echo "#################################### State 1 done ####################################"
sudo reboot
