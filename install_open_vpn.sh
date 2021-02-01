#!/bin/bash
DISTRO=focal
sudo apt install apt-transport-https
cd /var/tmp/
sudo wget https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub
sudo apt-key add openvpn-repo-pkg-key.pub
sudo wget -O /etc/apt/sources.list.d/openvpn3.list https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-$DISTRO.list
sudo apt update
sudo apt install openvpn3
cd -

echo openvpn3 config-import --config /path/to/your.ovpn --name VPN
echo openvpn3 configs-list
echo openvpn3 session-start VPN