
#!/bin/bash

# Function to add an application to the LXQt panel
add_app_to_panel() {
    local app_path="$1"

    # Define the path to panel.conf
    local panel_conf="$HOME/.config/lxqt/panel.conf"

    # Check if panel.conf exists
    if [ ! -f "$panel_conf" ]; then
        echo "Error: panel.conf not found at $panel_conf"
        return 1
    fi

    # Find the current apps size
    local current_size
    current_size=$(grep -oP 'apps\\size=\K[0-9]+' "$panel_conf")

    # Check if the size was found
    if [ -z "$current_size" ]; then
        echo "Error: apps size not found in $panel_conf"
        return 1
    fi

    # Calculate the next index and new size
    local new_size=$((current_size + 1))

    # Define the new entry
    local new_entry="apps\\\\$new_size\\\\desktop=$app_path"

    # Use sed to insert the new entry before the pattern and update the size
    sed -i "/apps\\\\size=$current_size/i $new_entry" "$panel_conf"
    sed -i "s/apps\\\\size=$current_size/apps\\\\size=$new_size/" "$panel_conf"

    # Restart the LXQt panel to apply changes
    lxqt-panel --exit
    lxqt-panel &

    echo "App $new_entry installed"
}

# Function to update system packages
update_system() {
    sudo apt update && sudo apt upgrade -y
}

# Function to clean up temporary files
cleanup_temp_files() {
    sudo rm -rf /tmp/*
    echo "Temporary files cleaned up."
}

# Function to install desktop
install_desktop(){
  sudo apt-get --no-install-recommends install -y lxqt-core gvfs
  sudo apt-get install -y openbox lightdm #
  
  echo "Desktop installed"
  sleep 2
}

# Function to install packages
install_packages(){
  sudo apt-get install -y thonny   # Install Thonny
  sudo apt-get install -y chromium
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
  
  echo "Packges installed"
  sleep 2
}

