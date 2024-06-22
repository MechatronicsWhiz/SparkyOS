#!/bin/bash

# Function to reboot and indicate the script phase
reboot_system() {
    phase=$1
    echo $phase > /tmp/script_phase
    echo "System will reboot now to continue with phase $phase."
    sudo reboot
}

# Read the current phase
if [ -f /tmp/script_phase ]; then
    phase=$(cat /tmp/script_phase)
else
    phase="start"
fi

case $phase in
    "start")
        # Phase 1: Update package lists and install LXQt, GVFS
        sudo apt update
        sudo apt upgrade -y
        sudo apt --no-install-recommends install lxqt-core gvfs -y
        
        # Reboot to apply changes
        reboot_system "desktopSetup"
        ;;
        
    "desktopSetup")
        # Phase 2: Install Openbox and LightDM
        sudo apt install openbox lightdm -y
        
        # Reboot to apply changes
        reboot_system "addingPackages"
        ;;
        
    "addingPackages")
        # Phase 3: Install additional packages and configure autologin
        sudo apt install chromium thonny python3-pyqt5 python3-pyqt5.qtwebengine -y
        sudo raspi-config nonint do_boot_behaviour B4
        
        # Cleanup and final reboot
        rm /tmp/script_phase
        echo "Setup is complete. The system will reboot one last time."
        sudo reboot
        ;;
        
    *)
        echo "Unknown phase: $phase. Starting from the beginning."
        rm -f /tmp/script_phase
        exec $0
        ;;
esac
