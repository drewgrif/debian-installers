 #!/bin/bash

# Default packages are for the configuration and corresponding .config folders
# Install packages after installing base Debian with no GUI

# xorg display server installation
sudo apt install -y xorg xbacklight xbindkeys xvkbd xinput

# PACKAGE INCLUDES build-essential.
sudo apt install -y build-essential

# Microcode for Intel/AMD 
# sudo apt install -y amd-microcode
sudo apt install -y intel-microcode 

# Network File Tools/System Events
sudo apt install -y dialog mtools dosfstools avahi-daemon acpi acpid gvfs-backends

sudo systemctl enable avahi-daemon
sudo systemctl enable acpid

# File Manager (eg. pcmanfm,krusader)
sudo apt install -y thunar

# Terminal (eg. terminator,kitty,xfce4-terminal)
sudo apt install -y terminator

# Sound packages
sudo apt install -y pulseaudio alsa-utils pavucontrol volumeicon-alsa

# Neofetch/HTOP
sudo apt install -y neofetch htop

# Network Manager
sudo apt install -y network-manager network-manager-gnome 

# Installation for Appearance management
sudo apt install -y lxappearance 

# Browser Installation (eg. chromium)
sudo apt install -y firefox-esr 

# Desktop background browser/handler 
# feh --bg-fill /path/to/directory 
# sudo apt install -y nitrogen 
sudo apt install -y feh
 
# Fonts and icons for now
sudo apt install -y fonts-firacode fonts-liberation2 fonts-ubuntu papirus-icon-theme 

# Openbox packages
sudo apt install -y openbox dunst dbus-x11 feh hsetroot i3lock libnotify-bin lximage-qt menu picom  qt5-style-plugins rofi scrot tint2 xfce4-power-manager 

# LXDM login manager
sudo apt install -y lxdm

########################################################
# End of script for default config
#

## These two scripts will install nerdfonts and copy my configuration files into the ~/.config directory
## Configuration uses 

source ~/i3gaps-debian/nerdfonts.sh
source ~/i3gaps-debian/copyconf.sh

sudo apt autoremove

printf "\e[1;32mYou can now reboot! Thanks you.\e[0m\n"

