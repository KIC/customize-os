#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo cp "$DIR/md5" /usr/bin/md5
echo 'alias md5="md5sum"' >> ~/.bashrc

