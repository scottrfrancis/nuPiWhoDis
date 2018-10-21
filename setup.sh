#!/bin/bash

echo "!! Do these steps manually"; echo ""
echo "sudo rpi-update"
echo "sudo reboot"
echo "-----------"
echo "sudo apt update && sudo apt upgrade -y"

sudo apt-get install git,python-pip -y
sudo apt install vim, tree -y
