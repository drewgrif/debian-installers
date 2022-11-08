#!/bin/bash

# Default packages are for the configuration and corresponding .config folders
# Install packages after installing base Debian with no GUI

# xorg display server installation
sudo apt install -y xorg xbacklight xbindkeys xvkbd xinput

# Build-essential.
sudo apt install -y build-essential 

# Microcode for Intel/AMD 
# sudo apt install -y amd64-microcode
sudo apt install -y intel-microcode 

#XFCE packages
sudo apt install -y xfce4 xfce4-goodies

# Browser Installation (eg. chromium)
sudo apt install -y firefox-esr 

# Network File Tools/System Events
sudo apt install -y dialog mtools acpi acpid gvfs-backends

sudo systemctl enable avahi-daemon
sudo systemctl enable acpid

# Sound packages (pulseaudio installed prior)
sudo apt install -y alsa-utils volumeicon-alsa

# Neofetch/HTOP
sudo apt install -y neofetch htop

# EXA installation
# replace ls command in .bashrc file with line below
# alias ls='exa -al --long --header --color=always --group-directories-first' 
sudo apt install -y exa

# Printing and bluetooth (if needed)
sudo apt install -y cups
sudo apt install -y bluez blueman

sudo systemctl enable bluetooth
sudo systemctl enable cups

# Command line text editor -- nano preinstalled  -- I like micro but vim is great
# sudo apt install -y micro
sudo apt install -y vim

# Install fonts
sudo apt install fonts-font-awesome fonts-powerline fonts-ubuntu fonts-liberation2 fonts-liberation fonts-terminus


# Install LightDM GTK Greeter Settings (lightdm,lightdm-gtk-greeter installs with xfce)

sudo apt install -y lightdm-gtk-greeter-settings
sudo systemctl enable lightdm

sudo apt autoremove

printf "\e[1;32mTime to reboot! Thanks!\e[0m\n"
