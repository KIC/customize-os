#!/bin/bash

mkdir ~/bin
cp disable-touch.sh ~/bin/

sudo sed -i 's/PATH="/PATH="~\/bin:/' /etc/environment
