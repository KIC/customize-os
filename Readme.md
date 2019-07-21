## Install Pop!_OS with raid 0 on Lenovo X1 Extreme
Just download and flash the installation media, I have used 19.04/6. Once you arive at the installation options choose "Try Demo Mode" on the bottom left. Then open a terminal and perform a `sudo su`.

### In Try Demo Mode
Open gparted and create 2 identical partitions on each disk, one of size 500MiB and leave the rest for second partition. It should look somehow like this (where sdb* is the installation media):

```
pop-os@pop-os:~$ lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
NAME          SIZE FSTYPE   TYPE MOUNTPOINT
loop0         2.2G squashfs loop /rofs
sdb           7.3G iso9660  disk /cdrom
├─sdb1        2.3G iso9660  part
└─sdb2        2.8M vfat     part
nvme0n1     238.5G          disk
├─nvme0n1p1   500M vfat     part
└─nvme0n1p2   238G btrfs    part
nvme1n1     238.5G          disk
├─nvme1n1p1   500M          part
└─nvme1n1p2   238G btrfs    part 
```

Next create the raid by using the dedicated bigger partition:

```
sudo mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/nvme0n1p2 /dev/nvme1n1p2


pop-os@pop-os:~$ lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
NAME      SIZE FSTYPE            TYPE  MOUNTPOINT
loop0     2.2G squashfs          loop  /rofs
sdb       7.3G iso9660           disk  /cdrom
├─sdb1    2.3G iso9660           part  
└─sdb2    2.8M vfat              part  
nvme0n1 238.5G linux_raid_member disk  
└─md0   476.7G                   raid0
nvme1n1 238.5G linux_raid_member disk  
└─md0   476.7G                   raid0
```

Now start the Installer from the Launcher

### In the Installer
Keep the shell terminal open and start the Installer (via Launcher) and choose "Advanced Installation" (not the "Clean Install"). You should see 3 devices, each individual disk and the raid you have just created. Create a gpt partiton table and a full size btrfs partition on the raid by using the gparted tool. 

Then you need to select one of the two 500MiB partitions on one of the individual disk and use it as `/boot` and use the full raid device as root `/`. 

Install the system on it -> but whatever you do, DO NOT RESTART after the finished installation!

### Back in the terminal of your still running Demo Session
Now we need to make the installation to know about the raid. Therefore we first mount the raid in the Demo-Session:

```
mkdir /mnt/raid0
mount /dev/md0 /mnt/raid0/
```

Then we create the mdadm config. Just to be clear here, we change the etc files on the mounted raid not the root /etc/ of your currently running linux!

```
cd /mnt/raid0
mdadm --detail --scan --verbose >> etc/mdadm.conf
```

Finally change the fstab to connect to the raid `nano etc/fstab` so it looks like this:

```
kic@pop-os:~$ cat /etc/fstab 
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system>  <mount point>  <type>  <options>  <dump>  <pass>
#UUID=b5ce6a38-f1f8-4cbf-a2c7-621d0d9f810c  /  btrfs  defaults  0  0
/dev/md0                                       /          btrfs defaults    0 0
PARTUUID=2a857570-7595-437e-9a18-3f17cf419a9b  /boot/efi  vfat  umask=0077  0  0
```

Now you can go back to the installer and reboot. Eventually you are lucky and your Linux boots :-)








