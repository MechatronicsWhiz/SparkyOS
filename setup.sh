#!/bin/bash

# 1. Download shell scripts
sudo wget "https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/update_upgrade.sh" -O $HOME/update_upgrade.sh
sudo wget "https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/install_desktop.sh" -O $HOME/install_desktop.sh
sudo wget "https://raw.githubusercontent.com/MechatronicsWhiz/SparkyOS/main/config_desktop.sh" -O $HOME/config_desktop.sh

sudo chmod +x $HOME/update_upgrade.sh
sudo chmod +x $HOME/install_desktop.sh
sudo chmod +x $HOME/config_desktop.sh

# 2. Add a script to crontab
add_to_crontab() {
    local script_path=$1
    (crontab -l 2>/dev/null; echo "@reboot $script_path") | crontab -
}


echo "##################################################################"
echo "############################ Starting ############################"
sleep 5

# 3. Add script1 to crontab
script1_path="$HOME/update_upgrade.sh" 

# Add script1 to crontab
add_to_crontab $script1_path

sudo reboot
