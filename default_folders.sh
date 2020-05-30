#!/bin/bash

mkdir /var/tmp/Downnloads
cp -ar ~/Downloads/ /var/tmp/Downnloads
rm -rf ~/Downloads/
ln -s /var/tmp/Downnloads ~/Downloads
ln -s ~/Downloads/ ~/downloads

ln -s ~/Documents ~/files

