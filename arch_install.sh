#!/bin/sh
echo "Install: loadkeys"
loadkeys uk

echo "Install: timedatectl"
timedatectl set-ntp true

echo "Install: parted"
parted /dev/sda mklabel gpt 
parted /dev/sda mkpart "EFI" fat32 1MiB 512MiB 
parted /dev/sda mkpart "root" btrfs 512MiB 100% 
parted /dev/sda set 1 esp on

echo "Install: mkfs"
mkfs.fat -F32 /dev/sda1
mkfs.btrfs -f /dev/sda2

echo "Install: mounting"
mount -o compress=zstd,noatime,discard=async /dev/sda2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

echo "Install: reflector"
reflector --latest 100 --sort rate --protocol https,https \
  --country 'France,Germany,United Kingdom' --save /etc/pacman.d/mirrorlist

echo "Install: pacstrap"
pacstrap /mnt base linux linux-firmware iwd zram-generator grub efibootmgr sudo intel-ucode

echo "Install: genfstab"
genfstab -U /mnt >> /mnt/etc/fstab

echo "Install: place second install script"
cat << EOF > /mnt/root/install.sh

echo "Install: enable iwd.service"
systemctl enable --now iwd.service

echo "Install: enable systemd-resolved.service"
systemctl enable --now systemd-resolved.service

echo "Install: symlink /etc/resolv.conf"
ln -s /var/run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

echo "Install: enable IWD DHCP"
mkdir /etc/iwd
	tee /etc/iwd/main.conf <<- END > /dev/null
	[General]
	EnableNetworkConfiguration=true
	END

echo "Install: enable timezone"
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

echo "Install: set locales"
sed -i 's/#en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo 'LANG=en_GB.UTF-8' >> /etc/locale.conf
echo 'KEYMAP=uk' >> /etc/vconsole.conf

echo "Install: set hostname"
echo 'arch' >> /etc/hostname

echo "Install: setup zram-generator"

	tee /etc/systemd/zram-generator.conf <<- END  > /dev/null
	[zram0]
	max-zram-size = 8192
	END

echo "Install: mkinitcpio"
mkinitcpio -P

echo "Install: grub"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig  -o /boot/grub/grub.cfg

echo "Install: adduser (charper - no password)"
useradd -m -G wheel charper
passwd -d charper

echo "Install: permit wheel group access to sudo"
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

EOF

echo "Install: remove /etc/resolv.conf before chroot to allow symlink"
rm /mnt/etc/resolv.conf

echo "Install: arch-chroot"
arch-chroot /mnt sh /root/install.sh

echo "Install: cleanup"

rm /mnt/root/install.sh

echo "Install: finished"


