#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install LightDM and Weston
sudo apt install -y lightdm weston

# Create the Weston session file for LightDM
sudo tee /usr/share/xsessions/weston.desktop > /dev/null <<EOL
[Desktop Entry]
Name=Weston
Comment=This session runs Weston
Exec=weston
Type=Application
EOL

# Set Weston as the default session for LightDM
sudo sed -i '/^#.*user-session=/c\user-session=weston' /etc/lightdm/lightdm.conf

# Reboot the system
echo "Installation complete. The system will now reboot."
sudo reboot
