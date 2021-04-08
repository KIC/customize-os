#!/bin/bash

sudo apt install cups hplip hplip-gui
sudo usermod -a -G lpadmin your-username

hp-setup $1
