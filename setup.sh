#!/bin/bash

: <<'END'
This is the master installation shell script for SparkyBotOS
Comment out sections as needed.
END

# Function to download and check success
download_and_verify() {
  local url=$1
  local dest=$2
  wget "$url" -O "$dest"
  if [ $? -ne 0 ]; then
    echo "Failed to download $url"
    exit 1
  fi
  chmod +x "$dest"
}

# 1. Download shell scripts
download_and_verify "https://raw.githubusercontent.com/SparkyAutomation/SparkyOS/main/install_desktop.sh" "$HOME/install_desktop.sh"
download_and_verify "https://raw.githubusercontent.com/SparkyAutomation/SparkyOS/main/install_apps.sh" "$HOME/install_apps.sh"
download_and_verify "https://raw.githubusercontent.com/SparkyAutomation/SparkyOS/main/config_desktop.sh" "$HOME/config_desktop.sh"

# 2. Install desktop environment
$HOME/install_desktop.sh
if [ $? -ne 0 ]; then
  echo "install_desktop.sh failed"
  exit 1
fi

# 3. Install apps
$HOME/install_apps.sh
if [ $? -ne 0 ]; then
  echo "install_apps.sh failed"
  exit 1
fi

# 4. Configure the OS
$HOME/config_desktop.sh
if [ $? -ne 0 ]; then
  echo "config_desktop.sh failed"
  exit 1
fi

echo "###########################################################################"
echo "############################ Installation done ############################"
sleep 2

# Clean up downloaded scripts
rm -f $HOME/install_desktop.sh $HOME/install_apps.sh $HOME/config_desktop.sh

# Reboot system
sudo reboot
