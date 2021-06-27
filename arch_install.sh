#!/bin/sh

loadkeys uk
iwctl 
timedatectl set-ntp true
parted /dev/sda mklabel gpt mkpart "EFI" fat32 1MiB 512MiB mkpart "root" btrfs 512MiB 100% set 1 esp on
mkfs.fat -F32 /dev/sda1
mkfs.btrfs /dev/sda2

mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
mount -o compress=zstd,noatime /dev/sda2 /mnt

reflector --latest 100 --sort rate --protocol https,https \
  --country 'France,Germany,United Kingdom' --save /etc/pacman.d/mirrorlist

pacstrap /mnt base linux linux-firmware iwd grub efibootmgr zram-generator

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

systemctl enable --now iwd.service

ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/'
locale-gen
echo 'LANG=en_GB.UTF-8' >> /etc/locale.conf
echo 'KEYMAP=uk' >> /etc/vconsole.conf
echo 'arch' >> /etc/hostname

tee /etc/systemd/zram-generator.conf <<- EOF > /dev/null
[zram0]
max-zram-size = 8192
EOF

mkinitcpio -P
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig  -o /boot/grub/grub.cfg

useradd -m -G wheel charper
echo 'password' | passwd charper 


su charper
cd /home/charper
sh -c "$(curl -fsLS git.io/chezmoi) -b ~/.local/bin -- init --apply chrisharper"





