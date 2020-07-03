# Base system

```shell
/* If empty then it's BIOS */
# ls /sys/firmware/efi/efivars

# wifi-menu
# ping ya.ru
# timedatectl set-ntp 1

# lsblk
# parted
/* UEFI/GPT */
(parted) mkpart primary fat32 2MiB 261MiB           /* /mnt/efi (2MiB just in case) */
(parted) set 1 esp on
(parted) mkpart primary ext4 261MiB 20.5GiB         /* /mnt */
(parted) mkpart primary linux-swap 20.5GiB 24.5GiB  /* SWAP */
(parted) mkpart primary ext4 24.5GiB 100%           /* /mnt/home */
/* BIOS/MBR */
(parted) mkpart primary ext4 2MiB 20GiB             /* /mnt (2MiB for GRUB) */
(parted) set 1 boot on
(parted) mkpart primary linux-swap 20GiB 24GiB      /* SWAP */
(parted) mkpart primary ext3 24GiB 100%             /* /mnt/home */

# mkfs.ext4 /dev/sdX1
# mkswap /dev/sdX2
# swapon /dev/sdX2
# mount /dev/sdX1 /mnt      /* /mnt/efi, /mnt/home */

# vim /etc/pacman.d/mirrorlist
# pacstrap /mnt \
    base linux linux-firmware \
    e2fsprogs dosfstools exfat-utils ntfs-3g \
    neovim xsel less \
    networkmanager \
    man-db man-pages texinfo

# genfstab -U /mnt >> /mnt/etc/fstab
# cat /mnt/etc/fstab

# arch-chroot /mnt

# ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
# hwclock --systohc

# nvim /etc/locale.gen
# locale-gen
# echo 'LANG=en_US.UTF-8' > /etc/locale.conf

# echo 'rch' > /etc/hostname
# nvim /etc/hosts
---
127.0.0.1	localhost
::1		    localhost
127.0.1.1	rch.localdomain	rch
---
# systemctl enable NetworkManager.service

# passwd

/* UEFI/GPT */
/* amd-ucode for AMD CPU, os-prober to detect other OSes */
# pacman -S intel-ucode grub os-prober efibootmgr
# grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
/* BIOS/MBR */
# pacman -S intel-ucode grub os-prober
# grub-install --target=i386-pc /dev/sdX

# grub-mkconfig -o /boot/grub/grub.cfg

# exit
# umount -R /mnt
# reboot
```

# After installation

```shell
# pacman -S sudo
# useradd -m restonich
# passwd restonich
# groupadd sudo
# usermod -aG sudo restonich
# EDITOR=nvim visudo        /* uncomment %sudo */

# nmtui
/**
 * # nmcli device
 * # nmcli device wifi list
 * # nmcli device wifi connect <SSID> password <pass> [ifname wlp2s0]
 */
```

## GNOME desktop

```shell
# pacman -Suy gnome
# systemctl enable gdm.service bluetooth.service
```

## Xfce desktop

```shell
# pacman -Suy xorg xfce4 xfce4-goodies lightdm lightdm-gtk-greeter
# systemctl enable lightdm.service
```

## VMWare guest

```
```

