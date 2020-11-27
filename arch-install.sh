#!/bin/bash

fdisk /dev/sda

mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt/

mv arch-chroot.sh /mnt/

pacstrap -i /mnt/ base base-devel

genfstab -U -p /mnt >> /mnt/etc/fstab


arch-chroot /mnt/
