#!/bin/bash
IMGSIZE=16M

# create image
dd if=/dev/zero of=disk.img bs=1 count=0 seek=${IMGSIZE}

# create partition table
parted -s disk.img mklabel msdos

# create boot partition
parted -s --align=none disk.img mkpart primary 0 100%

# make bootable
parted -s --align=none disk.img set 1 boot on

# add syslinux mbr
dd bs=440 conv=notrunc count=1 if=/usr/lib/syslinux/mbr.bin of=disk.img

# attach loopback
sudo losetup /dev/loop0 disk.img

# add partitions
sudo kpartx -a /dev/loop0

# create filesystems
sudo mkfs -t ext4 /dev/mapper/loop0p1

# mount filesystems
sudo mkdir /mnt/vmboot
sudo mount /dev/mapper/loop0p1 /mnt/vmboot

# install syslinux in dir
sudo extlinux --install /mnt/vmboot

# install kernel and config
sudo cp boot/* /mnt/vmboot

# unmount
sudo umount /mnt/vmboot
sudo rmdir /mnt/vmboot

# remove partitions
sudo kpartx -d /dev/loop0

# detach loopback
sudo losetup -d /dev/loop0

# convert to qcow2
kvm-img convert -O qcow2 disk.img disk.qcow2
