#!/bin/bash


sudo sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT=\"/# GRUB_CMDLINE_LINUX_DEFAULT=\"/" /etc/default/grub
sudo sh -c "echo 'GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash nopti nospectre_v2 spectre_v2_user=off spec_store_bypass_disable=off l1tf=off\"' >> /etc/default/grub"
sudo update-grub



