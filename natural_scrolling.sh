#!/bin/bash

sudo sed -i 's/touchpad catchall"$/touchpad catchall"\n        Option "NaturalScrolling" "true"/' /usr/share/X11/xorg.conf.d/40-libinput.conf
