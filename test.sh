#!/bin/bash

# Default packages are for the configuration and corresponding .config folders
# Install packages after installing base Debian with no GUI
echo "This script is intended for Debian Bullseye Mininal Install"
read -p "Do you want to proceed? (yes/no) " yn

case $yn in 
	yes ) echo ok, we will proceed;;
	no ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 1;;
esac

echo "****  Adding unstable/sid to apt list   ****"
echo
echo 'deb http://deb.debian.org/debian/ unstable main non-free contrib' | tee -a /etc/apt/sources.list
echo
echo
echo "****   Adding Preferences to Apt List   ****"
echo
cat > ./temp << "EOF"
Package: *
Pin: release a=bullseye
Pin-Priority: 500

Package: linux-image-amd64
Pin: release a=unstable
Pin-Priority: 900

Package: *
Pin: release a=unstable
Pin-Priority: 100
EOF
sudo cp ./temp /etc/apt/preferences;rm ./temp

echo
echo "****  Add Latest Kernel from Debian Sid  ****"
echo
sudo apt update && sudo apt upgrade 
echo
echo "****  Remove Debian Bullseye Kernel   ****"
sudo apt autoremove -y
echo
echo "****  Installing Xorg packages from Debian Stable  ****"
echo
# xorg display server installation
sudo apt install -y xorg xbacklight xbindkeys xvkbd xinput xorg-dev
echo
echo "****  Installing Build Essential from Debian Stable  ****"
echo
# INCLUDES make,etc.
sudo apt install -y build-essential 

echo
echo "****  Installing Microcode from Debian Stable  ****"
echo
# Microcode for Intel/AMD 
# sudo apt install -y amd64-microcode
sudo apt install -y intel-microcode 
echo
echo "****  Installing Thunar from Debian Sid   ****"
echo
# you may want to sub nemo but takes a lot more packages
sudo apt install -t unstable thunar -y

echo
echo "****  Installing Tilix terminal from Debian Stable   ****"
echo
# Terminal (eg. terminator,kitty,xfce4-terminal)
sudo apt install -y tilix

echo
echo "****  Installing Tools from Debian Stable   ****"
echo
sudo apt install git mtools dosfstools acpi acpid timeshift -y
sudo systemctl enable acpid

echo
echo "****  Installing GVFS-Backends from Debian Sid   ****"
echo
sudo apt install -t unstable avahi-daemon gvfs-backends -y
sudo systemctl enable avahi-daemon
sudo apt autoremove -y

echo
echo "****  Installing Neofetch/Htop from Debian Stable   ****"
echo
# Neofetch/HTOP
sudo apt install -y neofetch htop

echo
echo "****  Installing Exa from Debian Stable   ****"
echo
# EXA installation
# replace ls command in .bashrc file with line below
# alias ls='exa -al --long --header --color=always --group-directories-first' 
sudo apt install -y exa

echo
echo "****  Installing CUPS from Debian Stable   ****"
echo
# Printing and bluetooth (if needed)
sudo apt install -y cups simple-scan
sudo systemctl enable cups

echo
echo "****  Installing Firefox from Debian Sid   ****"
echo
# Browser Installation (eg. chromium)
sudo apt install -t unstable firefox-esr -y

echo
echo "****  Installing Additional Tools from Debian Sid   ****"
echo
# Packages needed dwm after installation
sudo apt install -t unstable numlockx file-roller policykit-1-gnome scrot gedit micro -y

echo
echo "****  Installing Fonts from Debian Stable   ****"
echo
# Install fonts
sudo apt install fonts-font-awesome fonts-ubuntu fonts-liberation2 fonts-liberation fonts-terminus 

# Create folders in user directory (eg. Documents,Downloads,etc.)
xdg-user-dirs-update

echo
echo "****  Installing Ly Console Manager from Github   ****"
echo
# Install Lightdm Console Display Manager
# sudo apt install -y lightdm lightdm-gtk-greeter-settings slick-greeter
# sudo systemctl enable lightdm


# Ly Console Manager
# Needed packages
sudo apt install -y libpam0g-dev libxcb-xkb-dev
cd 
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly
make
sudo make install installsystemd
sudo systemctl enable ly.service

echo
echo "****  Installing Budgie Desktop from Debian Sid   ****"
echo
sudo apt install -t unstable budgie-desktop
sudo apt install -t unstable budgie-indicator-applet
sudo apt install -t unstable gnome-control-center

echo
echo "****  Installing Fonts from Debian Stable   ****"
echo
sudo apt install -t unstable numix-icon-theme numix-gtk-theme materia-gtk-theme papirus-icon-theme

echo
echo "****  Installing Nerdfonts from Github   ****"
echo
# Install Nerd Fonts
source ~/budgie-debian/nerdfonts.sh

sudo apt autoremove

printf "\e[1;32mDone! you can now reboot.\e[0m\n"


