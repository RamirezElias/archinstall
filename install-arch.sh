#!/bin/bash


$ sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << FDISK_CMDS  | sudo fdisk /dev/sda
g      # create new GPT partition
n      # add new partition
1      # partition number
       # default - first sector
+550MiB # partition size
n      # add new partition
2      # partition number
       # default - first sector
       # default - last sector
t      # change partition type
1      # partition number
1     # Linux filesystem
w      # write partition table and exit
FDISK_CMDS
mkfs.vfat -F 32 /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt/

pacstrap -i /mnt/ base base-devel

genfstab -U -p /mnt >> /mnt/etc/fstab

arch-chroot /mnt

sudo pacman -S --needed firefox thunar i3 konsole vim  xorg-server xorg-xinit xorg fakeroot bluefish gparted Network-Manager nitrogen sudo efibootmgr make grub

echo en_US.UTF-8 >> /etc/locale.gen

locale-gen

ln -sf /usr/share/zoneinfo/America/Los_Angles /etc/localtime

hwclock --systohc

echo dev > /etc/hostname

echo 127.0.0.1   localhost '\n' ::1 '\n' localhost 127.0.1.1    dev.localdomain    dev >> /etc/hosts

systemctl enable dhcpcd

echo root:password | chpasswd



useradd -m dev

echo dev:password | chpasswd

usermod -aG wheel,audio,video,optical,storage dev

pacman -S --needed grub os-prober sudo

#EDITOR=nano visudo
EDITOR=nano visudo

mkdir /boot/EFI


mount /dev/sda /boot/EFI/

grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck

grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --needed network-manager-applet

systemctl enable NetworkManager


grub-mkconfig -o /boot/grub/grub.cfg

exit
reboot
