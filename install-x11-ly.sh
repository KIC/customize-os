#!/bin/bash

sudo apt-get install intel-media-va-driver-non-free awesome xinit xterm aterm xinput
sudo apt install xbacklight alsa-utils libsox-fmt-mp3

# display manafer
cd /var/tmp/
git clone https://github.com/nullgemm/ly.git
cd ly
make github
sudo make install
sudo systemctl enable ly.service
sudo systemctl disable getty@tty2.service
cd ..

