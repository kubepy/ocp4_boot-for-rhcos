#!/bin/bash
GRUB_NUM="'coreos'"

if [ -n "$(grep -i 'coreos' /etc/*release)" ]; then
    ostree admin unlock --hotfix || true
    mount -o rw,remount /boot || true
    mount -o rw,remount /boot/efi || true
    touch /etc/default/grub 
    echo -e "GRUB_DEFAULT=$GRUB_NUM\nGRUB_ENABLE_BLSCFG=true" > /etc/default/grub
    if [ -d /sys/firmware/efi ]; then
        grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg
    else
        grub2-mkconfig -o /boot/grub2/grub.cfg
    fi
else
    sed -i "s#GRUB_DEFAULT=.*#GRUB_DEFAULT=$GRUB_NUM#" /etc/default/grub || true
    [ -d /sys/firmware/efi ] && grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg || grub2-mkconfig -o /boot/grub2/grub.cfg
fi
