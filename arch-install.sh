#!/bin/bash

fdsik /dev/sda

mkfs.vfat -F 32 /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt/

pacstrap -i /mnt/ base base-devel

genfstab -U -p /mnt >> /mnt/etc/fstab

mv arch-chroot.sh /mnt/

arch-chroot /mnt
