#!/bin/bash
ln -sf /usr/share/zoneinfo/America/Los_Angles /etc/localtime

hwclock --systohc

pacman -S --needed --noconfirm i3-gaps i3blocks i3lock i3status nano


pacman -S  --needed --noconfirm firefox thunar konsole xorg-server xorg-xinit xorg 
pacman -S   --needed --noconfirm fakeroot bluefish gparted nitrogen sudo efibootmgr make grub

sed -i 's|#en_US.UTF-8 UTF-8|en_US.UTF-8 UTF-8|' /etc/locale.gen

locale-gen


echo Please, Enter a hostname
read -p 'hostname: ' HostNamevar
echo $HostNamevar >> /etc/hostname

echo 127.0.0.1   localhost '\n' ::1 '\n' localhost 127.0.1.1    dev.localdomain    dev >> /etc/hosts

###################################### Put your own password for the root user here
echo Please, Enter a Root Password
read -sp 'Password: ' RootPasswordvar
echo root:$RootPasswordvar | chpasswd
##################################################################################

# Change the user name dev to your own username 
echo Please, Enter a UserName
read -p 'Username: ' UserNamevar
echo Please, Enter a Password for $UserNamevar

read -sp 'Password: ' UserPasswordvar
useradd -m $UserNamevar

# make sure to change the username to your username and password here from above.#######
echo $UserNamevar:$UserPasswordvar | chpasswd
##############################################################################

usermod -aG wheel,audio,video,optical,storage $UserNamevar
#Change dev to your username

pacman -S --needed --noconfirm os-prober sudo

#EDITOR=nano visudo
EDITOR=nano visudo
pacman -S --needed --noconfirm grub efibootmgr dosfstools os-prober mtools

 mkdir /boot/EFI

mount /dev/sda1 /boot/EFI/

grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck

grub-mkconfig -o /boot/grub/grub.cfg

pacman -S  --noconfirm networkmanager

echo exec i3 '\n' >> /etc/X11/xinit/xinitrc
sed -i 's|twm &|#twm &|' /etc/X11/xinit/xinitrc
sed -i 's|xclock|#xclock|' /etc/X11/xinit/xinitrc
sed -i 's|exec xterm|#exec xterm|' /etc/X11/xinit/xinitrc
sed -i 's|xterm|#xterm|g' /etc/X11/xinit/xinitrc
sed -i 's|bindsym $mod+d exec --no-startup-id i3-dmenu-desktop|#bindsym $mod+d exec --no-startup-id i3-dmenu-desktop|' .config/i3/config

# pacman -S --noconfirm nvidia nvidia-utils    # NVIDIA
# pacman -S --noconfirm xf86-video-amdgpu mesa   # AMD
# pacman -S --noconfirm xf86-video-intel mesa    # Intel
pacman -S --needed --noconfirm lightdm lightdm-gtk-greeter dmenu
systemctl enable lightdm


 systemctl enable NetworkManager

