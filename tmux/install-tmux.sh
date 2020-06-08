#!/bin/bash

sudo apt install tmux
cp .tmux.conf ~/

mkdir -p ~/bin 
cp tmux-session.sh ~/bin 
