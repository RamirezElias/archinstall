#!/bin/bash
ln -sf /usr/share/zoneinfo/America/Los_Angles /etc/localtime

hwclock --systohc

pacman -S --needed i3-gaps i3blocks i3lock i3status nano


pacman -S  --needed firefox thunar konsole xorg-server xorg-xinit xorg 
pacman -S  --needed fakeroot bluefish gparted nitrogen sudo efibootmgr make grub

nano /etc/locale.gen

locale-gen





# change the dev to whatever hostname you want
echo dev >> /etc/hostname

echo 127.0.0.1   localhost '\n' ::1 '\n' localhost 127.0.1.1    dev.localdomain    dev >> /etc/hosts

systemctl enable dhcpcd
###################################### Put your own password for the root user here
echo root:password | chpasswd
##################################################################################

# Change the user name dev to your own username 
useradd -m dev

# make sure to change the username to your username and password here from above.#######
echo dev:password | chpasswd
##############################################################################

usermod -aG wheel,audio,video,optical,storage dev  
#Change dev to your username

pacman -S --needed grub os-prober sudo

#EDITOR=nano visudo
EDITOR=nano visudo
pacman -S --needed grub efibootmgr dosfstools os-prober mtools

 mkdir /boot/EFI

mount /dev/sda1 /boot/EFI/

grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck

grub-mkconfig -o /boot/grub/grub.cfg

pacman -S networkmanager

 systemctl enable NetworkManager

