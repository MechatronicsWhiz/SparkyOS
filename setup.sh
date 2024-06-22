#!/bin/bash

# Phase 1: Update package lists and install LXQt, GVFS
sudo apt update
sudo apt upgrade -y
sudo apt --no-install-recommends install lxqt-core gvfs -y
# sudo reboot
        
# Phase 2: Install Openbox and LightDM
sudo apt install openbox lightdm -y
# sudo reboot

# Phase 3: Install additional packages and configure autologin
sudo apt install chromium-browser thonny python3-pyqt5 python3-pyqt5.qtwebengine -y
sudo raspi-config nonint do_boot_behaviour B4
# sudo reboot

# Phase 4: Configure the desktop
panel_conf="/home/sparky/.config/lxqt/panel.conf"

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
font-color=@Variant(\0\0\0\x43\0\xff\xff\0\0\0\0\0\0\0\0)
hidable=false
hide-on-overlap=false
iconSize=140
lineCount=1
lockPanel=false
opacity=58
panelSize=120
plugins=mainmenu, quicklaunch
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


