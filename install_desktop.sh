#!/bin/bash
################ Phase 1: Update and upgrade ################
sudo apt-get update
sudo apt-get upgrade -y

################ Phase 2: Install desktop environment ################
sudo apt-get --no-install-recommends install -y lxqt-core gvfs
sudo apt-get install -y weston xwayland lightdm #openbox

echo "##################################################################"
echo "########################## Phase 2 done ##########################"
sleep 2


################ Phase 3: Install additional packages and configure autologin ################
# Install Thonny
sudo apt-get install -y thonny

# Install Chromium (Chromium is preferred over chromium-browser which may be deprecated in some systems)
sudo apt-get install -y chromium

# Install other required packages
sudo apt-get install -y python3-pyqt5 python3-pyqt5.qtwebengine

# Remove problematic packages and update rpi firmware
# sudo rpi-update -y
# sudo apt remove python3-rpi.gpio -y
# sudo pip3 install rpi-lgpio --upgrade RPi.GPIO --break-system-packages
# sudo pip install SMBus rpi-ws281x --break-system-packages

# Install development tools and libraries
# sudo apt-get install -y gcc make build-essential python-dev-is-python3 scons swig python3-pil python3-pil.imagetk
# sudo apt install -y python3-opencv python3-numpy
# sudo apt install -y python3-scipy python3-matplotlib python3-joblib python3-opencv
# pip install scikit-learn --break-system-packages
# python3 -m pip install mediapipe --break-system-packages

# Enable the autologin service
sudo raspi-config nonint do_boot_behaviour B4 # Set lightdm to use autologin
sudo systemctl enable lightdm.service

echo "##################################################################"
echo "########################## Phase 3 done ##########################"
sleep 2


