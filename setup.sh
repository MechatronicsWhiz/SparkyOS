#!/bin/bash

: <<'END'
This it the master installation shell script for SparkyBotOS
Comment out sections as needed.
END

# 1. Download shell scripts
sudo wget "https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/install_desktop.sh" -O $HOME/install_desktop.sh
sudo wget "https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/install_apps.sh" -O $HOME/install_apps.sh
sudo wget "https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/config_desktop.sh" -O $HOME/config_desktop.sh

sudo chmod +x $HOME/install_desktop.sh
sudo chmod +x $HOME/install_apps.sh
sudo chmod +x $HOME/config_desktop.sh

# 2. Install desktop environment
./install_desktop.sh
if [ $? -ne 0 ]; then
  echo "install_desktop.sh failed"
  exit 1
fi

# Install apps
./install_apps.sh
if [ $? -ne 0 ]; then
  echo "install_apps.sh failed"
  exit 1
fi

# Configure desktop
./config_desktop.sh
if [ $? -ne 0 ]; then
  echo "config_desktop.sh failed"
  exit 1
fi
echo "###########################################################################"
echo "############################ Installation done ############################"
sleep 2

sudo rm *
sudo reboot
