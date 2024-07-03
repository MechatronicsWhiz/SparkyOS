#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install LXQt core components
sudo apt install -y lxqt-core lxqt-config lxqt-panel

# Install Sway (Wayland compositor)
sudo apt install -y sway

# Install LightDM
sudo apt install -y lightdm lightdm-gtk-greeter

# Create a new session file for LXQt with Sway
SESSION_FILE="/usr/share/wayland-sessions/lxqt-sway.desktop"
echo "[Desktop Entry]
Name=LXQt Wayland (Sway)
Comment=Lightweight Qt Desktop Environment with Sway as the window manager
Exec=sway
Type=Application" | sudo tee $SESSION_FILE

# Enable LightDM to start on boot
sudo systemctl enable lightdm

echo "Installation complete. Please reboot your system and select the LXQt Wayland session on the login screen."

# Reboot the system
read -p "Do you want to reboot now? (y/n): " REBOOT
if [ "$REBOOT" = "y" ]; then
    sudo reboot
else
    echo "You can reboot later by running 'sudo reboot'."
fi
