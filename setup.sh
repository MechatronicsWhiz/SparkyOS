#!/bin/bash

# Phase 1: Update package lists and install LXQt, GVFS
sudo apt update
sudo apt upgrade -y
sudo apt --no-install-recommends install lxqt-core gvfs -y

# Check if the above commands succeeded
if [ $? -ne 0 ]; then
    echo "Phase 1 failed. Exiting script."
    exit 1
fi

# Phase 2: Install Openbox and LightDM
sudo apt install openbox lightdm -y

# Check if the above command succeeded
if [ $? -ne 0 ]; then
    echo "Phase 2 failed. Exiting script."
    exit 1
fi

# Phase 3: Install additional packages and configure autologin
sudo apt install chromium-browser thonny python3-pyqt5 python3-pyqt5.qtwebengine -y
sudo raspi-config nonint do_boot_behaviour B4

# Check if the above commands succeeded
if [ $? -ne 0 ]; then
    echo "Phase 3 failed. Exiting script."
    exit 1
fi

# Fix GPIO pin problems for Raspberry Pi 5
sudo rpi-update -y
sudo apt remove python3-rpi.gpio -y
sudo pip3 install rpi-lgpio --upgrade RPi.GPIO --break-system-packages

# Install additional Python packages
sudo pip install Pillow SMBus rpi-ws281x --break-system-packages
sudo apt-get install gcc make build-essential python-dev-is-python3 scons swig python3-pil python3-pil.imagetk -y

# Install Apache and Python libraries for computer vision
sudo apt install -y apache2
sudo service apache2 start
sudo apt install -y python3-opencv python3-numpy

# Install Python machine learning packages
sudo apt install -y python3-scipy python3-matplotlib python3-joblib
pip install scikit-learn --break-system-packages
python3 -m pip install mediapipe --break-system-packages

# Phase 4: Configure the desktop panel for LXQt
panel_conf="$HOME/.config/lxqt/panel.conf"

# Ensure directory exists before writing panel configuration
mkdir -p "$(dirname "$panel_conf")"

# Define new panel settings
new_settings=$(cat <<EOF
[General]
__userfile__=true
iconTheme=

[mainmenu]
alignment=Left
type=mainmenu

[panel1]
alignment=0
animation-duration=0
background-color=@Variant(\0\0\0\x43\x1\xff\xff\0\0UU\x7f\x7f\0\0)
background-image=
desktop=0
font-color=@Variant(\0\0\0\x43\0\xff\xff\0\0\0\0\0\0\0)
hidable=false
hide-on-overlap=false
iconSize=140
lineCount=1
lockPanel=false
opacity=58
panelSize=120
plugins=mainmenu,quicklaunch
position=Left
reserve-space=true
show-delay=0
visible-margin=true
width=100
width-percent=true

[plugin-0]
alignment=left
type=menu

[plugin-1]
alignment=left
type=quicklaunch

[quicklaunch]
alignment=Left
type=quicklaunch
EOF
)

# Apply panel configuration
echo "$new_settings" > "$panel_conf"
echo "Panel configuration done"

