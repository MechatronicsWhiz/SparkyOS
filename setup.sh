#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Set noninteractive mode for apt-get
export DEBIAN_FRONTEND=noninteractive

################ Phase 1: Update and install LXQt, GVFS ################
sudo apt-get update
sudo apt-get upgrade 
sudo apt-get --no-install-recommends install lxqt-core gvfs
echo "Phase 1 done"

################ Phase 2: Install desktop environment ################
sudo apt-get install openbox lightdm
echo "Phase 2 done"

################ Phase 3: Install additional packages and configure autologin ################
sudo apt-get install chromium-browser thonny python3-pyqt5 python3-pyqt5.qtwebengine
sudo raspi-config nonint do_boot_behaviour B4

# Install additional Python packages
sudo pip install SMBus rpi-ws281x
sudo apt-get install gcc make build-essential python-dev-is-python3 scons swig

# Install Python libraries for computer vision
sudo apt-get install python3-opencv python3-numpy

# Install Python machine learning packages
sudo apt-get install python3-scipy python3-matplotlib python3-joblib
sudo pip install scikit-learn
sudo python3 -m pip install mediapipe
echo "Phase 3 done"

################ Phase 4: Configure the desktop for LXQt ################

# Define an array of files to download and replace
declare -a files=(
    "rc.xml:$HOME/.config/openbox/rc.xml"
    "lxqt.conf:$HOME/.config/lxqt/lxqt.conf"
    "lxqt-config-locale.conf:$HOME/.config/lxqt/lxqt-config-locale.conf"
    "panel.conf:$HOME/.config/lxqt/panel.conf"
    "session.conf:$HOME/.config/lxqt/session.conf"
    "settings.conf:$HOME/.config/pcmanfm-qt/lxqt/settings.conf"
)

# GitHub repository URL
github_repo="https://raw.githubusercontent.com/MechatronicsWhiz/sparkyos/main/configration/"

# Function to download files
download_file() {
    local filename=$1
    local local_path=$2
    local github_url="${github_repo}${filename}"

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

echo "Phase 4 done"

################ Reboot ################
echo "System update and setup completed successfully. Rebooting..."
sudo reboot
