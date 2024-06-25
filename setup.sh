#!/bin/bash

# 1. Download shell scripts
sudo wget "https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/install_desktop.sh" -O $HOME/install_desktop.sh
sudo wget "https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/config_desktop.sh" -O $HOME/config_desktop.sh

sudo chmod +x $HOME/install_desktop.sh
sudo chmod +x $HOME/config_desktop.sh

# 2. Execute the first script
./install_desktop.sh
if [ $? -ne 0 ]; then
  echo "script1.sh failed"
  exit 1
fi

# Execute the second script
./config_desktop.sh
if [ $? -ne 0 ]; then
  echo "script2.sh failed"
  exit 1
fi

echo "###########################################################################"
echo "############################ Installation done ############################"
sleep 2

sudo rm *
sudo reboot
