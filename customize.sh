#!/bin/sh

# hints
echo "restore ~/.ssh files from backup, chmod 400 them and execute ssh-add"

# update system
sudo apt-get update
sudo apt-get upgrade

# install software
sudo apt install -y software-properties-common apt-transport-https curl flameshot
sudo apt install -y vim dconf-editor imagemagick tesseract-ocr
sudo apt install -y snapd google-chrome-stable
sudo apt install -y openjdk-8-jdk visualvm 
sudo apt install -y nodejs
sudo apt install -y r-base
pip3 install undervolt


# install text cleaner
wget 'http://www.fmwconcepts.com/imagemagick/downloadcounter.php?scriptname=textcleaner&dirname=textcleaner' -O ~/bin/textcleaner
chmod +x ~/bin/textcleaner

# install ta-lib
cd /tmp
wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xzf ta-lib-0.4.0-src.tar.gz
cd ta-lib/
./configure --prefix=/usr
make
sudo make install
cd ~

# symlink annoing uppercase folders
ln -s Downloads downloads
ln -s Documents files

# install VSCode
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install -y code
sudo apt install -y ubuntu-make 

# install DBeaver
sudo apt install -y dbeaver-ce

# install Intellij
sudo add-apt-repository ppa:mmk2410/intellij-idea
sudo apt-get update
sudo apt -y install intellij-idea-community 

# install pycharm
sudo snap install pycharm-community --classic
echo type: snap run pycharm-community then add the icon to the launcher

# install python stuff
sudo apt install -y python3-pip
sudo apt install -y tensorflow-cuda-latest
sudo apt install -y jupyter-notebook
jupyter-notebook --generate-config
echo "c.NotebookApp.token='kic'" >> ~/.jupyter/jupyter_notebook_config.py 
sudo cp jupyter.service /etc/systemd/system
sudo systemctl enable jupyter.service 
sudo service jupyter start
pip3 install 'prompt-toolkit==1.0.15' # fix notebook error: https://www.reddit.com/r/Python/comments/94b8rz/ipython_cannot_import_name_create_prompt/
install -D custom.css ~/.jupyter/custom/custom.css

# install python modules
pip3 install pandas pandas-ml yfinance joblib matplotlib seaborn TA-Lib
pip3 install scikit-learn pycuda scikit-cuda

# append bash.rc for path and aliases
echo "export PATH=\$PATH:/home/$USER/bin" >> ~/.bashrc

# install awsudo
echo "install to /home/kic/bin/awsudo"
bash <(curl https://raw.githubusercontent.com/makethunder/awsudo/master/install)


# customize OS
# set scroll direction like on smart phones, increase pointer speed and disable tap and drag
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
gsettings set org.gnome.desktop.peripherals.touchpad speed "0.55"
gsettings set org.gnome.desktop.peripherals.touchpad tap-and-drag false
# move min,max,close to the right
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,maximize,minimize:'
# do not collapse the windows of the same application
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
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
sudo cp /usr/share/X11/xkb/symbols/pc /usr/share/X11/xkb/symbols/pc.bak
sudo cp pc /usr/share/X11/xkb/symbols/

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

# clean up
sudo apt autoremove

# install topicons
firefox https://extensions.gnome.org/extension/1031/topicons/
