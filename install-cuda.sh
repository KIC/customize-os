#!/bin/bash
sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
sudo bash -c "echo options nouveau modeset=0 >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
sudo update-initramfs -u

sudo apt install nvidia-headless-450-server nvidia-utils-450-server
sudo apt install --no-install-recommends nvidia-cuda-toolkit nvidia-cuda-toolkit-gcc nvidia-cuda-dev

echo sudo reboot

