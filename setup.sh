#!/bin/bash

# Ensure pip is installed and up-to-date
if ! command -v pip &> /dev/null; then
    sudo apt-get install -y python3-pip
    python3 -m pip install --upgrade pip
fi

################ Phase 1: Update and install LXQt, GVFS ################
sudo apt-get update
sudo apt-get upgrade -y
echo "#######################################"
echo "############# Phase 1 done#############"
echo "#######################################"
sleep 2

################ Phase 2: Install desktop environment ################
sudo apt-get --no-install-recommends install -y lxqt-core gvfs
sudo apt-get install -y openbox lightdm

# Set lightdm to use autologin
sudo raspi-config nonint do_boot_behaviour B4
sudo sed -i 's/^#autologin-user=.*/autologin-user=pi/' /etc/lightdm/lightdm.conf
sudo systemctl enable lightdm.service

echo "#######################################"
echo "############# Phase 2 done#############"
echo "#######################################"
sleep 2

################ Phase 3: Configure the desktop for LXQt ################
# Define an array of files to download and replace
declare -a files=(
    "rc.xml:$HOME/.config/openbox/rc.xml"
    "lxqt.conf:$HOME/.config/lxqt/lxqt.conf"
    "lxqt-config-locale.conf:$HOME/.config/lxqt/lxqt-config-locale.conf"
    "panel.conf:$HOME/.config/lxqt/panel.conf"
    "session.conf:$HOME/.config/lxqt/session.conf"
    "settings.conf:$HOME/.config/pcmanfm-qt/lxqt/settings.conf"
    "01_debian.conf:/usr/share/lightdm/lightdm-gtk-greeter.conf.d/01_debian.conf"
)

# GitHub repository URL
github_repo="https://raw.githubusercontent.com/MechatronicsWhiz/sparkyos/main/configration/"

# Function to download files
download_file() {
    local filename=$1
    local local_path=$2
    local github_url="${github_repo}${filename}"
    local dir_path=$(dirname "${local_path}")

    # Create directory if it doesn't exist
    if [ ! -d "${dir_path}" ]; then
        mkdir -p "${dir_path}"
        if [ $? -eq 0 ]; then
            echo "Created directory ${dir_path}"
        else
            echo "Failed to create directory ${dir_path}"
            exit 1
        fi
    fi

    # Download the file
    wget -q --show-progress --no-check-certificate -O "${local_path}" "${github_url}"
    if [ $? -eq 0 ]; then
        echo "Successfully downloaded ${filename} to ${local_path}"
    else
        echo "Failed to download ${filename}"
        exit 1
    fi
}

# Download each file from GitHub
for entry in "${files[@]}"; do
    IFS=':' read -ra file <<< "$entry"
    download_file "${file[0]}" "${file[1]}"
done

# Download images
WALLPAPER_DIR="/usr/share/lxqt/wallpapers"
GRAPH_DIR="/usr/share/lxqt/graphics"
sudo rm -f $WALLPAPER_DIR/*
sudo rm -f $GRAPH_DIR/*

# Download the new image from GitHub
sudo wget -O $WALLPAPER_DIR/$"wallpaper4.jpg" $"https://raw.githubusercontent.com/MechatronicsWhiz/sparkyos/main/resources/wallpaper4.jpg"
sudo wget -O $WALLPAPER_DIR/$"wallpaper5.png" $"https://raw.githubusercontent.com/MechatronicsWhiz/sparkyos/main/resources/wallpaper5.png"
sudo wget -O $GRAPH_DIR/$"settings_icon.png" $"https://raw.githubusercontent.com/MechatronicsWhiz/sparkyos/main/resources/settings_icon.png"
sudo wget -O $GRAPH_DIR/$"sparky_icon.png" $"https://raw.githubusercontent.com/MechatronicsWhiz/sparkyos/main/resources/sparky_icon.png"
sudo wget -O $GRAPH_DIR/$"hardware_icon.png" $"https://raw.githubusercontent.com/MechatronicsWhiz/sparkyos/main/resources/hardware_icon.png"


echo "#######################################"
echo "############# Phase 3 done#############"
echo "#######################################"
sleep 2


################ Phase 4: Install additional packages and configure autologin ################
sudo apt-get install -y chromium-browser thonny python3-pyqt5 python3-pyqt5.qtwebengine
sudo raspi-config nonint do_boot_behaviour B4

.'
sudo rpi-update -y 
sudo apt remove python3-rpi.gpio -y 
sudo pip3 install rpi-lgpio --upgrade RPi.GPIO --break-system-packages 

sudo pip install Pillow SMBus rpi-ws281x --break-system-packages 
sudo apt-get install gcc make build-essential python-dev-is-python3 scons swig python3-pil python3-pil.imagetk -y 
sudo apt install -y python3-opencv python3-numpy
sudo apt install -y python3-scipy python3-matplotlib python3-joblib 
pip install scikit-learn --break-system-packages 
python3 -m pip install mediapipe --break-system-packages
'

echo "#######################################"
echo "############# Phase 4 done#############"
echo "#######################################"
sleep 2

################ Reboot ################
echo "System update and setup completed successfully. Rebooting..."
sudo reboot
