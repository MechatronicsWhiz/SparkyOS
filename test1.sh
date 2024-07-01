#!/bin/bash

# Update package list and install lxqt-core with minimal dependencies
sudo apt-get update
sudo apt-get --no-install-recommends install -y lxqt-core gvfs

# Install Sway (Wayland compositor) and SDDM (display manager)
sudo apt-get install -y sway sddm

# Enable SDDM to start on boot
sudo systemctl enable sddm

# Create a custom session file for Sway with LXQt
sudo bash -c 'cat > /usr/share/wayland-sessions/lxqt-sway.desktop <<EOF
[Desktop Entry]
Name=LXQt with Sway
Comment=Start LXQt desktop environment with Sway
Exec=sway
Type=Application
EOF'

# Create the Sway configuration directory if it doesn't exist
mkdir -p ~/.config/sway

# Configure Sway to start LXQt
echo 'exec startlxqt' > ~/.config/sway/config

# Enable the autologin service
sudo raspi-config nonint do_boot_behaviour B4 # autologin

echo "Installation complete. Reboot your system to start LXQt with Sway on Wayland."
