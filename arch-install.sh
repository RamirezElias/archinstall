#!/bin/bash
timedatectl set-ntp true

fdisk /dev/sda << EOF
g
n
1

+550M
t
1
n
2


w
EOF

mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt/

mv arch-chroot.sh /mnt/

pacstrap /mnt base linux linux-firmware


genfstab -U /mnt >> /mnt/etc/fstab



arch-chroot /mnt/
