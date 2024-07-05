#!/bin/bash

# Define directories
WALLPAPER_DIR="/usr/share/lxqt/wallpapers"
GRAPH_DIR="/usr/share/lxqt/graphics"
CONFIG_URL="https://raw.githubusercontent.com/SparkyAutomation/SparkyOS/main/configuration"

# Define associative arrays
declare -A CONFIG_FILES=(
    ["$HOME/.config/openbox/rc.xml"]="rc.xml"
    ["$HOME/.config/lxqt/lxqt.conf"]="lxqt.conf"
    ["$HOME/.config/lxqt/lxqt-config-locale.conf"]="lxqt-config-locale.conf"
    ["$HOME/.config/lxqt/panel.conf"]="panel.conf"
    ["$HOME/.config/lxqt/session.conf"]="session.conf"
    ["$HOME/.config/pcmanfm-qt/lxqt/settings.conf"]="settings.conf"
    ["/usr/share/lightdm/lightdm-gtk-greeter.conf.d/01_debian.conf"]="01_debian.conf"
)

MENU_FILES=(
    "htop.desktop"
    "lxqt-config.desktop"
    "obconf.desktop"
    "pcmanfm-qt.desktop"
    "qterminal.desktop"
)

REMOVE_MENU_FILES=(
    "system-config-printer.desktop"
    "lxqt-leave.desktop"
    "lxqt-hibernate.desktop"
    "lxqt-suspend.desktop"
    "lxqt-lockscreen.desktop"
    "qterminal-drop.desktop"
    "vim.desktop"
)

# Remove existing images
sudo rm -f $WALLPAPER_DIR/* $GRAPH_DIR/*

# Download new images
sudo wget -q -O $WALLPAPER_DIR/desktop_background.png "https://raw.githubusercontent.com/SparkyAutomation/SparkyOS/main/resources/wallpaper1.png"
sudo wget -q -O $WALLPAPER_DIR/login-background.png "https://raw.githubusercontent.com/SparkyAutomation/SparkyOS/main/resources/wallpaper2.png"
sudo wget -q -O $GRAPH_DIR/apps.png "https://raw.githubusercontent.com/SparkyAutomation/SparkyOS/main/resources/apps.png"

# Download and replace configuration files
for local_path in "${!CONFIG_FILES[@]}"; do
    remote_file="${CONFIG_FILES[$local_path]}"
    remote_url="$CONFIG_URL/$remote_file"

    mkdir -p "$(dirname "$local_path")"
    sudo wget -q -O "$local_path" "$remote_url"
done

# Update menu items
for file in "${MENU_FILES[@]}"; do
    sudo wget -q -O "/usr/share/applications/${file}" "${CONFIG_URL}/${file}"
done
sudo wget -q -O /etc/xdg/menus/lxqt-applications.menu "${CONFIG_URL}/lxqt-applications.menu"

# Remove certain menu items
for file in "${REMOVE_MENU_FILES[@]}"; do
    sudo rm -f "/usr/share/applications/${file}"
done

# Completion message
echo "##################################################################"
echo "########################## Phase 2 done ##########################"
sleep 2
