#!/bin/bash

mkdir /mnt/hdd 
mount /dev/nvme0n1p2 /mnt/hdd
mount /dev/nvme0p1n1 /mnt/hdd/boot

# Now in order to have a functional chroot, we have to mount proc, dev and sys subsystems :
mount -t proc none /mnt/hdd/proc
mount -o bind /dev /mnt/hdd/dev
mount -o bind /sys /mnt/hdd/sys

# We need to have internet acces :
cp /etc/resolv.conf  /mnt/hdd/etc/resolv.conf

chroot /mnt/hdd /bin/bash
