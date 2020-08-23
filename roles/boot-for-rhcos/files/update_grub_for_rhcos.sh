#!/bin/bash
grub2-mkconfig -o /boot/grub2/grub.cfg
GRUB_NUM=`awk -F\' '$1=="menuentry " {print $2}' /etc/grub2.cfg | grep -v coreos | wc -l`
sed -i "s#GRUB_DEFAULT=.*#GRUB_DEFAULT=$GRUB_NUM#" /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
sed -i "s#^   set default=.[0-9].#   set default='$GRUB_NUM'#" /boot/grub2/grub.cfg
