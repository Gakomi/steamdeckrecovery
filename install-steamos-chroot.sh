#!/bin/bash
# -*- mode: sh; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: et sts=2 sw=2
#
# A collection of functions to repair and modify a Steam Deck installation.
# This makes a number of assumptions about the target device and will be
# destructive if you have modified the expected partition layout.
#

#Install steamos-chroot manually 
#copy steamos-partitions-lib
sudo mkdir /usr/lib/steamos
FILE_LIB="$(sudo find /run/media/* | grep steamos-partitions-lib)"
sudo cp "$FILE_LIB" /usr/lib/steamos/steamos-partitions-lib
#copy steamos-chroot
FILE_A="$(sudo find /run/media/* | grep completions/steamos-chroot)"
sudo cp "$FILE_A" /usr/share/bash-completion/completions/steamos-chroot 
FILE_B="$(sudo find /run/media/* | grep bin/steamos-chroot)"
sudo cp "$FILE_B" /usr/bin/steamos-chroot 
