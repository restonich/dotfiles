# TODO
 * renew base system installation
 * rewrite base system install as base is now a package and not a group with all packages needed
 * rewrite needed packages in fresh install
 * vmware setup (openvmtools and shared folder)
 * little tweaks: grub, wm autoload, shorten systemd task termination timer, ssh server and client settings
 * audio and keyboard layout settings
 * notifications settings

# Base system installation

### Create bootable USB
**Warning:** This will irrevocably destroy all data on `/dev/sdb`. To restore the USB drive as an empty, usable storage device after using the Arch ISO image, the ISO 9660 filesystem signature needs to be removed by running `wipefs --all /dev/sdb` as root, before repartitioning and reformating the USB drive.
```shell
/* find out drive name and make sure it is not mounted */
$ lsblk
/* write .iso to drive */
# dd bs=4M if=/path/to/archlinux.iso of=/dev/sdb status=progress oflag=sync
```

### Verify the boot mode
```shell
/* if the directory does not exist, the system may be booted in BIOS or CSM mode. */
# ls /sys/firmware/efi/efivars
```

### Check internet
`ip link`, `ping`
**TODO:** _Wi-Fi and ethernet configuration_

### Update the system clock
```shell
# timedatectl set-ntp true
# timedatectl status
```

### Partition the disk
Here's a creation of MBR partitions `root` (64GiB) and `swap` (4GiB) with help of the program `parted`.
It is requied to leave 1 or 2 MiB of space at the beginning to install GRUB and for disk allignment.
`lsblk` helps us to determine hard disk device. Most of the time it is `/dev/sda`.
_(Need to add about GPT partitioning)_
```shell
# lsblk
# parted /dev/sda
(parted) mktable msdos
(parted) mkpart primary ext4 2MiB 64GiB
(parted) mkpart primary linux-swap 64GiB 100%
(parted) set 1 boot on
(parted) print
(parted) quit
```

### Format and mount the partitions
```shell
# mkfs.ext4 /dev/sda1
# mkswap /dev/sda2
# swapon /dev/sda2

# mount /dev/sda1 /mnt
```
`swap` do not need to be mounted. If there are more partitions, they need to be mounted to corresponding directories, like `/mnt/home` for `/home`.

### Install base packages
```shell
/* place Russia mirrors on top */
# vim /etc/pacman.d/mirrorlist
# pacstrap /mnt base linux linux-firmware e2fsprogs
    iproute2 dhcpcd netctl
    neovim less
    man-db man-pages
```

### Fstab
```shell
# genfstab -U /mnt >> /mnt/etc/fstab
/* check for errors */
# cat /mnt/etc/fstab
```

### Chroot
```shell
# arch-chroot /mnt
```
---

### Time
```shell
# ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
# hwclock --systohc
```

### Localization
Uncomment `en_US.UTF-8 UTF-8` and `ru_RU.UTF-8 UTF-8` in `/etc/locale.gen` and generate them:
```plaintext
# nvim /etc/locale.gen
---
en_US.UTF-8 UTF-8
ru_RU.UTF-8 UTF-8
---
# locale-gen

# nvim /etc/locale.conf
---
LANG=en_US.UTF-8
---
```

### Network configuration
Hostname:
```plaintext
# nvim /etc/hostname
----
rch
```

Static lookup table:
```plaintext
# nvim /etc/hosts
----
127.0.0.1   localhost
::1         localhost
```

Copy `netctl` ethernetexample and edit interface name in it:
```plaintext
# cp /etc/netctl/examples/ethernet-dhcp /etc/netctl/
# nvim /etc/netctl/ethernet-dhcp
# netctl enable ethernet-dhcp
```

### Root password
```plaintext
# passwd
```

### Microcode and GRUB
```plaintext
# grub-install --target=i386-pc /dev/sda
# grub-mkconfig -o /boot/grub/grub.cfg
```

### Reboot
```plaintext
# exit
# umount -R /mnt
# reboot
```

# Base usable system installation

### Install some packages
`xorg-server xorg-xinit` -- Xorg server and startup (no DM)
`xdg-user-dirs` -- Downloads, Pictures, Music and others in home dir
`xdg-utils` -- for `xdg-open` (open URLs and others with correct apps)
`i3-wm i3status` -- i3 window manager
`rofi` -- app launcher
`dex` -- XDG-autostart
`xsel` -- clipboard support for Neovim (`xclip` do not saves clipboard after closing app)
`ttf-*` and `adobe-*` -- bunch of good fonts (adobe for asian characters)
`sudo zsh zsh-completions dash kitty neovim ranger` -- sudo, shells, terminal emulator, Neovim and CLI file manager
`git make gcc openssh firefox pcmanfm` -- dev stuff, SSH, internet browser and GUI file manager
```plaintext
# pacman -Syu
# pacman -S xorg-server mesa xorg-xinit xdg-utils \
            i3-wm i3status i3lock rofi dex xsel \
            ttf-opensans ttf-fira-code ttf-dejavu \
            adobe-source-han-sans-otc-fonts \
            sudo zsh zsh-completions neovim ranger \
            git make gcc openssh firefox gnome-terminal
```

### Add user
set password, add to sudo group and log out of root:
```plaintext
# useradd -m restonich
# passwd restonich
# EDITOR=nvim visudo
# exit
```

### Add russian keyboard layout to Xorg
```plaintext
# localectl --no-convert set-x11-keymap us,ru pc105 , grp:win_space_toggle
```

# Additional configuration

### Configure xinit autostart
```plaintext
$ cp /etc/X11/xinit/xinitrc ~/.xinitrc
$ nvim ~/.xinitrc
----
...
dex -a -e i3
exec i3
```

### Autostart X at login
Add the following to the bottom of `~/.bash_profile` or `~/.zprofile`, depending on login shell:
```plaintext
$ nvim ~/.bash_profile
----
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx
fi
```

### Hide GRUB menu 
unless ESC is pressed:
```plaintext
# nvim /etc/default/grub
----
...
GRUB_TIMEOUT=1
GRUB_TIMEOUT_STYLE=hidden
...
----
# grub-mkconfig -o /boot/grub/grub.cfg
```

### Enable OpenSSH daemon
```plaintext
# systemctl enable --now sshd.service
```

# Making it look good

_Fonts, i3, i3status and i3bar, rofi, kitty, nvim, lxappearance_

# VirtualBox guest cofiguration

### Install Guest Additions
For the default linux kernel choose `virtualbox-guest-modules-arch`:
```plaintext
# pacman -S virtualbox-guest-utils xf86-video-vmware
```

### Load kernel modules
```plaintext
# systemctl enable vboxservice.service
```
Another services should be started by `dex` via `/etc/xdg/autostart/vboxclient.desktop` (it is XDG Autostart)
Although this services starts at startup, it may be needed to run them manually one time with `dex -a`. Then everything will be good.

