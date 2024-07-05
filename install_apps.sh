#!/bin/bash

# Function to download specified files from a GitHub folder URL to a specified directory
# Arguments:
#   $1: GitHub folder URL
#   $2: Array of files to download
function download_files {
    github_folder_url="$1"
    files=("${@:2}")

    local_file_dir="/usr/local/bin/"
    local_app_dir="$HOME/.local/share/applications/"

    # Loop through each file and download to the appropriate directory
    for file in "${files[@]}"; do
        # Determine target directory based on file type
        if [[ "$file" == *.desktop ]]; then
            target_dir="$local_app_dir"
        else
            target_dir="$local_file_dir"
        fi

        # Create directory if it does not exist
        mkdir -p "$target_dir"

        # Download file using wget
        sudo wget -q --show-progress -O "${target_dir}${file}" "${github_folder_url}${file}"
    done
}

# Download files
file_url="https://raw.githubusercontent.com/SparkyAutomation/SparkyOS/main/configuration/"
files_to_download=(
    "styles.py"
    "functions.sh"
)
download_files "$file_url" "${files_to_download[@]}"

# Download apps
app_builder_url="https://raw.githubusercontent.com/SparkyAutomation/SparkyOS/main/apps/app_builder/"
app_builder_download=(
    "AppBuilder.desktop"
    "app_builder.py"
    "app_builder_icon.png"
)


################ Phase 2: Install additional packages and configure autologin ################
download_files "$app_builder_url" "${app_builder_download[@]}"


# Install Thonny
sudo apt-get install -y thonny

# Install Chromium (Chromium is preferred over chromium-browser which may be deprecated in some systems)
sudo apt-get install -y chromium

# Install other required packages
sudo apt-get install -y python3-pyqt5 python3-pyqt5.qtwebengine

# Remove problematic packages and update rpi firmware
sudo rpi-update -y
sudo apt remove python3-rpi.gpio -y
sudo pip3 install rpi-lgpio --upgrade RPi.GPIO --break-system-packages
sudo pip install SMBus rpi-ws281x --break-system-packages

# Install development tools and libraries
sudo apt-get install -y gcc make build-essential python-dev-is-python3 scons swig python3-pil python3-pil.imagetk
sudo apt install -y python3-opencv python3-numpy
sudo apt install -y python3-scipy python3-matplotlib python3-joblib python3-opencv
pip install scikit-learn --break-system-packages
python3 -m pip install mediapipe --break-system-packages

echo "##################################################################"
echo "########################## Phase 2 done ##########################"
sleep 2
