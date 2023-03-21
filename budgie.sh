#!/bin/bash
# Copyright 2023 
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


# Default packages are for the configuration and corresponding .config folders
# Install packages after installing base Debian with no GUI

echo
echo "****************************************************"
echo "****  RECOMMENDATION TO ONLY USE IF YOU ARE ON  ****"
echo "****      DEBIAN BULLSEYE MINIMAL INSTALL       ****"
echo
echo "This script is intended for Debian Bullseye Mininal Install"
read -p "Do you want to proceed? (yes/no) " yn

case $yn in 
	yes ) echo ok, we will proceed;;
	no ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 1;;
esac
echo
echo
echo "***************************************************"
echo "****  Adding Debian unstable/sid to apt list   ****"
echo
echo
sudo echo 'deb http://deb.debian.org/debian/ unstable main non-free contrib' | sudo tee -a /etc/apt/sources.list
echo
echo "********************************************"
echo "****   Adding Preferences to Apt List   ****"
echo
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

echo "*********************************************"
echo "****  Add Latest Kernel from Debian Sid  ****"
echo
sudo apt update -yy && sudo apt upgrade -yy
echo
echo
echo "******************************************"
echo "****  Remove Debian Bullseye Kernel   ****"
echo
sudo apt autoremove -yy
echo
echo
echo "*******************************************************"
echo "****  Installing Xorg packages from Debian Stable  ****"
echo
# xorg display server installation
sudo apt install -yy xorg xbacklight xbindkeys xvkbd xinput xorg-dev
echo
echo
echo "*********************************************************"
echo "****  Installing Build Essential from Debian Stable  ****"
echo
# INCLUDES make,etc.
sudo apt install -yy build-essential 
echo
echo
echo "***************************************************"
echo "****  Installing Microcode from Debian Stable  ****"
echo
# Microcode for Intel/AMD 
# sudo apt install -y amd64-microcode
sudo apt install -yy intel-microcode 
echo
echo
echo "**********************************************"
echo "****  Installing Thunar from Debian Sid   ****"
echo
# you may want to sub nemo but takes a lot more packages
sudo apt install -t unstable thunar -yy
echo
echo
echo "*********************************************************"
echo "****  Installing Tilix terminal from Debian Stable   ****"
echo
# Terminal (eg. terminator,kitty,xfce4-terminal)
sudo apt install -yy tilix
echo
echo
echo "************************************************"
echo "****  Installing Tools from Debian Stable   ****"
echo
sudo apt install mtools dosfstools acpi acpid timeshift -yy
sudo systemctl enable acpid
echo
echo
echo "*****************************************************"
echo "****  Installing GVFS-Backends from Debian Sid   ****"
echo
sudo apt install -t unstable avahi-daemon gvfs-backends -yy
sudo systemctl enable avahi-daemon
sudo apt autoremove -yy
echo
echo
echo "********************************************************"
echo "****  Installing Neofetch/Htop from Debian Stable   ****"
echo
# Neofetch/HTOP
sudo apt install -yy neofetch htop
echo
echo
echo "**********************************************"
echo "****  Installing Exa from Debian Stable   ****"
echo
# EXA installation
# replace ls command in .bashrc file with line below
# alias ls='exa -al --long --header --color=always --group-directories-first' 
sudo apt install -yy exa
echo
echo
echo "********************************************"
echo "****  Installing CUPS from Debian Sid   ****"
echo
# Printing and bluetooth (if needed)
sudo apt install -t unstable cups simple-scan -yy
sudo systemctl enable cups
echo
echo
echo "***********************************************"
echo "****  Installing Firefox from Debian Sid   ****"
echo
# Browser Installation (eg. chromium)
sudo apt install -t unstable firefox-esr -yy
echo
echo "****************************************************************************"
echo "****  Installing Compression, Gedit and OpenVPN Tools from Debian Sid   ****"
echo
# Packages needed after installation
sudo apt install -t unstable unzip file-roller gedit network-manager-openvpn-gnome-yy
echo
echo
echo "************************************************"
echo "****  Installing Fonts from Debian Stable   ****"
echo
# Install fonts
sudo apt install fonts-font-awesome fonts-ubuntu fonts-liberation2 fonts-liberation fonts-terminus  -yy
echo
# Create folders in user directory (eg. Documents,Downloads,etc.)
xdg-user-dirs-update
echo "******************************************************"
echo "****  Installing Ly Console Manager from Github   ****"
echo
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
echo
echo "******************************************************"
echo "****  Installing Budgie Desktop from Debian Sid   ****"
echo
sudo apt install -t unstable budgie-desktop -yy
sudo apt install -t unstable budgie-indicator-applet -yy
sudo apt install -t unstable gnome-control-center -yy
echo
echo
echo "****  Installing Sample Themes and Icons from Debian Sid   ****"
echo
sudo apt install -t unstable numix-icon-theme numix-gtk-theme materia-gtk-theme papirus-icon-theme dmz-cursor-theme -yy
echo
echo "****  Installing Nerdfonts from Github   ****"
echo
# Install Nerd Fonts
source ~/debian-installers/nerdfonts.sh
echo
echo "********************************"
echo "****   Autoremove command   ****"
sudo apt autoremove -yy
echo

printf "\e[1;32mDone! you can now reboot.\e[0m\n"


