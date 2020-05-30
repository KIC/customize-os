#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SWAP_ID=`grep swap /etc/fstab | grep UUID | cut -d" " -f1 | cut -d"=" -f2`

sudo sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=UUID=$SWAP_ID /" /etc/default/grub
sudo update-grub

sudo sh -c "echo 'RESUME=UUID=$SWAP_ID' >> /etc/initramfs-tools/conf.d/resume"
sudo cp "$DIR/com.ubuntu.enable-hibernate.pkla" /etc/polkit-1/localauthority/50-local.d/


