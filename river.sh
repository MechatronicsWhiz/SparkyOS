#!/bin/bash

# Update package lists
sudo apt update

# Install necessary dependencies
sudo apt install -y cmake meson ninja-build libwayland-dev libxcb-composite0-dev libxcb-xkb-dev libxcb-xinput-dev libxcb-image0-dev libpixman-1-dev

# Clone the River repository
git clone https://github.com/ifreund/river.git
cd river

# Build and install River
meson build
cd build
ninja
sudo ninja install

# Create River configuration directory and file
mkdir -p ~/.config/river
cat << EOF > ~/.config/river/config
# Example configuration for River

# Set the background color
background_color #000000

# Set the default terminal emulator
terminal urxvt

# Set the default layout for new windows (stacking)
default_orientation vertical

# Keybindings
Mod1+Return spawn urxvt
EOF

# Install additional applications if needed (e.g., terminal emulator, file manager, browser)
# sudo apt install -y urxvt nautilus firefox

# Provide instructions for reboot
echo "River installed. Please reboot your system to start River."
echo "Use 'river' command to start River after reboot."

# Reboot prompt
read -p "Would you like to reboot now? (y/n): " answer
if [ "$answer" == "y" ]; then
    sudo reboot
else
    echo "Please reboot manually to start River."
fi
