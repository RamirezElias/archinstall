#!/bin/bash
ln -sf /usr/share/zoneinfo/America/Los_Angles /etc/localtime

hwclock --systohc

yes | pacman -S --needed i3-gaps i3blocks i3lock i3status nano


yes | pacman -S  --needed firefox thunar konsole xorg-server xorg-xinit xorg 
yes | pacman -S  --needed fakeroot bluefish gparted nitrogen sudo efibootmgr make grub

sed -i 's|#en_US.UTF-8 UTF-8|en_US.UTF-8 UTF-8|' /etc/locale.gen

locale-gen





# change the dev to whatever hostname you want
echo dev >> /etc/hostname

echo 127.0.0.1   localhost '\n' ::1 '\n' localhost 127.0.1.1    dev.localdomain    dev >> /etc/hosts

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

yes | pacman -S --needed grub os-prober sudo

#EDITOR=nano visudo
EDITOR=nano visudo
yes | pacman -S --needed grub efibootmgr dosfstools os-prober mtools

 mkdir /boot/EFI

mount /dev/sda1 /boot/EFI/

grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck

grub-mkconfig -o /boot/grub/grub.cfg

yes | pacman -S networkmanager

echo exec i3 '\n' >> /etc/X11/xinit/xinitrc
sed -i 's|twm &|#twm &|' /etc/X11/xinit/xinitrc
sed -i 's|xclock|#xclock|' /etc/X11/xinit/xinitrc
sed -i 's|exec xterm|#exec xterm|' /etc/X11/xinit/xinitrc
sed -i 's|xterm|#xterm|g' /etc/X11/xinit/xinitrc

# yes |  pacman -S nvidia nvidia-utils    # NVIDIA
# yes |  pacman -S xf86-video-amdgpu mesa   # AMD
# yes |  pacman -S xf86-video-intel mesa    # Intel
yes | pacman -S lightdm lightdm-gtk-greeter
systemctl enable lightdm


 systemctl enable NetworkManager

