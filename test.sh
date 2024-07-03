#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install LXQt core components
echo "Installing LXQt core components..."
sudo apt install -y lxqt-core lxqt-config lxqt-panel

# Install Sway (Wayland compositor)
echo "Installing Sway..."
sudo apt install -y sway

# Install LightDM
echo "Installing LightDM and the GTK greeter..."
sudo apt install -y lightdm lightdm-gtk-greeter

# Create a new session file for LXQt with Sway
SESSION_FILE="/usr/share/wayland-sessions/lxqt-sway.desktop"
echo "Creating the LXQt Wayland (Sway) session file..."
sudo tee $SESSION_FILE > /dev/null <<EOL
[Desktop Entry]
Name=LXQt Wayland (Sway)
Comment=Lightweight Qt Desktop Environment with Sway as the window manager
Exec=sway
Type=Application
EOL

# Enable LightDM to start on boot
echo "Enabling LightDM to start on boot..."
sudo systemctl enable lightdm

# Inform the user that the installation is complete
echo "Installation complete. Please reboot your system and select the LXQt Wayland session on the login screen."

# Ask the user if they want to reboot now
read -p "Do you want to reboot now? (y/n): " REBOOT
if [ "$REBOOT" = "y" ]; then
    sudo reboot
else
    echo "You can reboot later by running 'sudo reboot'."
fi
