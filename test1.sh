#!/bin/bash

# Update package lists and upgrade existing packages
sudo apt update
sudo apt upgrade -y

# Install essential packages for minimal Wayland desktop environment
sudo apt install -y \
    wlroots \
    sway \
    alacritty \
    thunar \
    mousepad \
    firefox-wayland \
    slstatus \
    wl-clipboard \
    grim \
    slurp \
    brightnessctl \
    network-manager \
    adwaita-icon-theme \
    adwaita-gtk-theme \
    pulseaudio \
    gnome-keyring \
    lightdm \
    lightdm-webkit2-greeter

# Enable the autologin service in LightDM
sudo raspi-config nonint do_boot_behaviour B4 # autologin
sudo systemctl enable lightdm.service

# Create sway config directory if not exists
mkdir -p ~/.config/sway

# Example sway config (you may adjust this according to your needs)
cat << EOF > ~/.config/sway/config
# Example Sway config file
#
# This is a basic Sway configuration file.
# See man 5 sway for a complete reference.
#
# Some basic options:
#
# Set the output layout
output HDMI-A-1 pos 0 0 res 1920x1080
#
# Configure default programs
# exec swaymsg 'output * scale 2'  # Example: HiDPI scaling
exec gnome-keyring-daemon --start --components=pkcs11,secrets,ssh
exec slstatus
#
# Bindings
#
bindsym Mod1+Return exec alacritty
#
# Start swaybar for i3-like bar
bar {
    position top
    status_command slstatus
    # Example colors
    colors {
        background #323232
        statusline #FFFFFF
    }
}
EOF

# Reboot to apply changes
echo "#################################### State 1 done ####################################"
sudo reboot
