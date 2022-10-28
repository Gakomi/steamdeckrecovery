DO NOT RUN THE SCRIPTS WITHOUT READING THIS AS YOU STILL NEED TO DO SOME THINGS IN ORDER FOR THEM TO RUN

# This is for people that can't boot in to recovery media

This is due to Valve making a recovery image that boots only when you are using some specific usb sticks or sd memory cards.

KEEP IN MIND IT'S A WORKAROUND THAT I FOUND IN ORDER TO FIX MY DECK
I'M NOT RESPONSIBLE FOR ANY DAMAGE YOU DO TO YOUR OWN DEVICE 
PLEASE DON'T ATTEMPT THIS IF YOU DON'T UNDERSTAND IT 

Prerequisits:
You need a usb hub 
Keybord 
2 usbstiks or 1 usb and 1 sd card

First you need a recovery image usb/sd card (does not matter if it can't boot from it as we are not booting form it)

Second get a live media with holoiso 

Get the recovery scripts from here (they are the same ones that are on the recovery image from valve, only repair_device.sh was modified)

For the script to wark you need steamos-chroot (as I did not find a way to install it I copied it from the recovery image directly) ->
-> go to recovery image rootfs partition and open a terminal (you can do this from gui or from terminal but you need to open a terminal in this partition) ->
-> in terminal you will have to find all the files related to steamos-chroot to do this use command sudo find * | grep steamos-chroot -> 
-> this should show you 2 files copy them to the exact same path on your live media root, you need to use sudo in order to copy them -> 
-> steamos-chroot needs steamos-partitions-lib in order to work so you need to find it too same as before sudo find * | grep steamos-partitions-lib -> 
-> copy that too -> now you should be all set for running the scripts (just run the one you need and it should work now)

Modifications done to repair_device.sh 

line "rootdevice="$(findmnt -n -o source / )" from original script was changed to "rootdevice="$(findmnt -n -o source /run/media/liveuser/rootfs)" 

and the following lines were removed:

 # Freeze our rootfs
    estat "Freezing rootfs"
    unfreeze() { fsfreeze -u /; }
    onexit+=(unfreeze)
    cmd fsfreeze -f /
