#!/bin/bash

################ Phase 1: Update and install LXQt, GVFS ################
sudo apt update
sudo apt upgrade -y
sudo apt --no-install-recommends install lxqt-core gvfs -y

# Check if the above commands succeeded
if [ $? -ne 0 ]; then
    echo "Phase 1 failed. Exiting script."
    exit 1
fi

################ Phase 2: Install desktop environment ################
sudo apt install openbox lightdm -y

# Check if the above command succeeded
if [ $? -ne 0 ]; then
    echo "Phase 2 failed. Exiting script."
    exit 1
fi

################ Phase 3: Install additional packages and configure autologin ################
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
sudo pip install SMBus rpi-ws281x --break-system-packages
sudo apt-get install gcc make build-essential python-dev-is-python3 scons swig python3-pil python3-pil.imagetk -y

# Install Apache and Python libraries for computer vision
sudo apt install -y apache2
sudo service apache2 start
sudo apt install -y python3-opencv python3-numpy

# Install Python machine learning packages
sudo apt install -y python3-scipy python3-matplotlib python3-joblib
pip install scikit-learn --break-system-packages
python3 -m pip install mediapipe --break-system-packages

################ Phase 4: Configure the desktop panel for LXQt ################
#!/bin/bash

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

# Iterate through each file in the array
for entry in "${files[@]}"
do
    # Split each entry by colon
    IFS=':' read -ra file <<< "$entry"
    filename="${file[0]}"
    local_path="${file[1]}"

    # Construct GitHub URL
    github_url="${github_repo}${filename}"

    # Download the file from GitHub
    echo "Downloading ${filename}..."
    wget -q --show-progress --no-check-certificate -O "${local_path}" "${github_url}"

    # Check if download was successful
    if [ $? -eq 0 ]; then
        echo "Successfully downloaded ${filename} to ${local_path}"
    else
        echo "Failed to download ${filename}"
    fi
done

echo "All files downloaded and replaced."

################ reboot ################
sudo reboot
