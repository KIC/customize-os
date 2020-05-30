#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# exchange page up/down with home/end keys
sudo cp /usr/share/X11/xkb/symbols/pc /usr/share/X11/xkb/symbols/pc.bak
sudo cp "$DIR/pc" /usr/share/X11/xkb/symbols/


