#! human
# consult https://www.raspberrypi.org/documentation/configuration/wireless/headless.md for more info

# execute on host comptuer to setup card

# download distro (usually a zip and save it somewhere)
# https://www.raspberrypi.org/downloads/raspbian/

mkdir -p ~/workspace/pi && pushd ~/workspace/pi
cp ~/Downloads/*raspbian*.zip ./

# unzip it
unzip *raspbian*.zip
# should make an img file

# figure out what device to burn
diskutil list
# find the mounted disk -- may need to run twice -- before and after
# disk will be `/dev/diskN` where N is a number like `/dev/disk5`

# substitute N in commands below

# format it
diskutil eraseDisk ExFAT Untitled /dev/diskN

# unmount it
diskutil unmountDisk /dev/diskN

# burn it -- note the r in rdisk below.  You will need to modify this command for the actual img file name
sudo dd bs=4m if=./*raspbian*.img of=/dev/rdiskN

# setup wifi, ssh, vnc, etc.
pushd /Volumes/boot
# (this is the card)

vim wpa_supplicant.conf 
# and add this
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
network={
    ssid="YOUR_NETWORK_NAME"
    psk="YOUR_PASSWORD"
    key_mgmt=WPA-PSK
}
# (fill out the ssid and key of course)

touch ssh
# (to enable ssh)
popd

# unmount the disk
diskutil eject /dev/diskN

# remove the card
# Install it in the pi and boot

ping raspberrypi.local
# and wait for a response to get IP number, etc

# install sshpass if you don't have it: 
#brew install http://git.io/sshpass.rb

ssh pi@raspberrypi.local
# 'raspberry'
# may need to delete previous entries in ~/.ssh/known_hosts

# change password!

# expand filesystem, update, et, 
sudo raspi-config

sudo apt update && sudo apt upgrade -y

sudo reboot
# some updates are delayed install

# setup VNC -- will need VNC for some hotel and other wifi login pages
sudo apt-get install realvnc-vnc-server realvnc-vnc-viewer -y

sudo raspi-config
# again... and enable VNC from Interfacing Options

# need to enable boot to desktop and set resolution in config.txt
sudo apt-get install lightdm


