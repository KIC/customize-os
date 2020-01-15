#!/bin/sh

# hints
echo "restore ~/.ssh files from backup, chmod 400 them and execute ssh-add"

# disable bluetooth
sudo cp rc.local /etc/

# disable packakit
sudo systemctl stop packagekit
sudo systemctl disable packagekit

# add virtual box repo
sudo sh -c 'echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" >> /etc/apt/sources.list.d/virtualbox.list' 
sudo su -c 'wget -q -O- http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc | apt-key add -'

# update system
sudo apt-get update
sudo apt-get upgrade

# install fish shell
sudo apt install fish
chsh -s to /usr/local/bin/fish

# install software
sudo apt install -y software-properties-common apt-transport-https curl flameshot terminator tlp tree
sudo apt install -y vim dconf-editor imagemagick tesseract-ocr
sudo apt install -y snapd google-chrome-stable
sudo apt install -y openjdk-8-jdk visualvm maven
sudo apt install -y virtualbox
sudo apt install -y exfat-fuse exfat-utils vlc
sudo apt install -y docker.io && sudo usermod -aG docker $USER
sudo apt install -y pdfshuffler
sudo apt install -y nodejs
sudo apt install -y r-base
pip3 install undervolt

# install wine
curl -sSL https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo apt-key add winehq.key
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ disco main'
sudo add-apt-repository ppa:cybermax-dexter/sdl2-backport
sudo apt-get update
sudo apt install -y wine-devel-amd64
sudo apt install --install-recommends winehq-devel

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
# reset java8 as default jre
sudo update-java-alternatives --jre-headless --jre --set java-1.8.0-openjdk-amd64

# install pycharm
sudo snap install pycharm-community --classic
echo type: snap run pycharm-community then add the icon to the launcher

# install python stuff
sudo apt install -y python3-pip
# install tensorflow cuda
sudo apt install -y tensorflow-cuda-latest nvtop
echo 'export PYTHONPATH=/usr/lib/tensorflow/lib/python3.7:$PYTHONPATH' | sudo tee -a /etc/profile.d/system76-cuda.sh
# install jupyther notebook
sudo apt install -y jupyter-notebook
jupyter-notebook --generate-config
echo "c.NotebookApp.token='kic'" >> ~/.jupyter/jupyter_notebook_config.py 
sudo cp jupyter.service /etc/systemd/system
sudo systemctl enable jupyter.service 
sudo service jupyter start
pip3 install 'prompt-toolkit==1.0.15' # fix notebook error: https://www.reddit.com/r/Python/comments/94b8rz/ipython_cannot_import_name_create_prompt/
pip3 install jupyter_contrib_nbextensions
install -D custom.css ~/.jupyter/custom/custom.css

# install python modules
pip3 install Cython
pip3 install pandas pandas-ml yfinance joblib matplotlib seaborn TA-Lib
pip3 install scikit-learn pycuda scikit-cuda
pip3 install spacy && python3 -m spacy download en
pip3 install pandas-profiling
pip3 install cachetools
pip3 install sortedcontainers
pip3 install xgboost
pip3 install keras-rectified-adam
pip3 install minisom

# append bash.rc for path and aliases
echo 'alias open="xdg-open"' >> ~/.bashrc
echo 'alias md5="md5sum"' >> ~/.bashrc
echo "export PATH=\$PATH:/home/$USER/bin" >> ~/.bashrc
echo 'export JAVA_TOOL_OPTIONS="-Didea.junit.message.length.threshold=10000000 -Dfile.encoding=UTF8 -Xss300M"' >> ~/.bashrc 

# install awsudo
echo "install to /home/kic/bin/awsudo"
bash <(curl https://raw.githubusercontent.com/makethunder/awsudo/master/install)
sudo apt install -y awscli

# maven bash complete
sudo wget https://raw.github.com/dimaj/maven-bash-completion/master/bash_completion.bash --output-document /etc/bash_completion.d/mvn

# Mac compaible md5
sudo cp md5 /usr/bin/

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
# disable soundeffects
gsettings set org.gnome.desktop.sound event-sounds false
# locate mouse cursor on control key
gsettings set org.gnome.settings-daemon.peripherals.mouse locate-pointer true
# 24h clock
gsettings set org.gnome.desktop.interface clock-format 24h

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

# indicate restart
echo "sudo shutdown -r now"

