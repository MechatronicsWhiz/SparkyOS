#!/bin/bash
################ Phase 1: Update and upgrade ################
sudo apt-get update
sudo apt-get upgrade -y
echo "##################################################################"
echo "########################## Phase 1 done ##########################"
sleep 2
sudo reboot
