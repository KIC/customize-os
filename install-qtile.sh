#!/bin/bash

# requirements
sudo apt install python3 python3-pip python-is-python3 libpangocairo-1.0-0 python3-dbus libnss3 libnss3-tools libnspr4 \
 libghc-iwlib-dev

# develop requirements
sudo apt-get install python3-pytest xserver-xephyr x11-apps apt-get install
sudo apt install xbacklight alsa-utils libsox-fmt-mp3 gcalcli ranger atool gpustat
sudo apt install fdpowermon && mkdir -p ~/.config/fdpowermon/
wget https://raw.githubusercontent.com/yoe/fdpowermon/master/theme.pl -O ~/.config/fdpowermon/theme.pl

pip3 install xcffib
pip3 install --no-cache-dir cairocffi
pip3 install qtile iwlib
wget "https://raw.githubusercontent.com/qtile/qtile/master/resources/qtile.desktop" -O /usr/share/xsessions/qtile.desktop
echo "/usr/share/xsessions/qtile.desktop eventually need to be fixed, should be 'Exec=qtile' not 'Exec=qtile start'"
