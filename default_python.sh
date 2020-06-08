#!/bin/bash

# add virtual envs
sudo apt-get install python3-dev python3-pip python3-venv python3-virtualenv 

# allow to use python 3.7 in virtual envs
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.7 python3.7-dev

# make python 3.8 the default
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 0
sudo update-alternatives --set python /usr/bin/python3.8
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 0
sudo update-alternatives --set pip /usr/bin/pip3

pip install pipenv

