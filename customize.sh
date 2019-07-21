#!/bin/sh

# hints
echo "restore ~/.ssh files from backup, chmod 400 them and execute ssh-add"

# update system
sudo apt-get update
sudo apt-get upgrade

# install software
sudo apt install vim dconf-editor 
sudo apt install snapd google-chrome-stable
sudo apt install python3-pip python3-notebook python3-nbformat || true


# customize OS
# set scroll direction like on smart phones
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
# move min,max,close to the right
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,maximize,minimize:'
# do not send display to sleep ever, use a short cut instead
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
gsettings set org.gnome.desktop.session idle-delay 0
# sh -c 'sleep 0.3 && xset dpms force off'
# dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Suspend" boolean:true
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Suspend"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Alt>F3"
#gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "sh -c 'sleep 0.3 && xset dpms force off'"
#gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

# exchange page up/down with home/end keys
echo "keycode 112=Home" > ~/.Xmodmap
echo "keycode 117=End" >>  ~/.Xmodmap	
echo "keycode 110=Prior" >>  ~/.Xmodmap
echo "keycode 115=Next" >>  ~/.Xmodmap
sudo bash -c 'echo "xmodmap ~/.Xmodmap" >> /etc/X11/xinit/xinitrc'

# make python3 the default
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.7 0
sudo update-alternatives --set python /usr/bin/python3.7
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 0
sudo update-alternatives --set pip /usr/bin/pip3

# enable backspace in firefox
PROFILE=`ls -1 ~/.mozilla/firefox | grep default$`
echo 'user_pref("browser.backspace_action","0");' > ~/.mozilla/firefox/$PROFILE/user.js


# setup folder structure for development
mkdir ~/source
mkdir ~/source/work
mkdir ~/source/private
mkdir ~/source/private/github
mkdir ~/source/github

mkdir ~/notebooks
mkdir ~/notebooks/work
mkdir ~/notebooks/private
mkdir ~/notebooks/private/github
mkdir ~/notebooks/github

mkdir ~/data
mkdir ~/data/work
mkdir ~/data/private

