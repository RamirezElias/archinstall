#!/bin/bash


sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${TGTDEV}
  o # clear the in memory partition table
  g # make partion table GPT
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk
  +550M # 100 MB boot parttion
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
    # default, extend partition to end of disk
  a # make a partition bootable
  1 # bootable partition is partition 1 -- /dev/sda1
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF
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
echo %wheel ALL=(ALL) ALL >> /etc/sudoers

mkdir /boot/EFI


mount /dev/sda /boot/EFI/

grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck

grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --needed network-manager-applet

systemctl enable NetworkManager


grub-mkconfig -o /boot/grub/grub.cfg

exit
reboot
