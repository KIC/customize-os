#!/bin/bash

sudo apt-get install python3-pip

# make python3 the default
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 0
sudo update-alternatives --set python /usr/bin/python3.8
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 0
sudo update-alternatives --set pip /usr/bin/pip3

