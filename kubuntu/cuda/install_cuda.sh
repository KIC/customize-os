#!/bin/bash 

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo cp 11-nvidia-prime.conf /usr/share/X11/xorg.conf.d/
sudo chattr +i /usr/share/X11/xorg.conf.d/11-nvidia-prime.conf

sudo apt-get install build-essential gcc-multilib dkms
sudo apt-get install nvidia-driver-440 nvidia-cuda-*

git clone https://github.com/NVIDIA/cuda-samples.git
sudo ln -s /usr/lib/nvidia-cuda-toolkit/ /usr/local/cuda

cd "$DIR/cuda-samples"
make || true

./bin/x86_64/linux/release/bandwidthTest
cp ./bin/x86_64/linux/release/bandwidthTest ~/bin/ || true
#nvidia-smi
