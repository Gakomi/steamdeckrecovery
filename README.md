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

Second get a live media with holoiso ( you can get the image from here https://github.com/theVakhovskeIsTaken/holoiso)

Get the recovery scripts from here (they are the same ones that are on the recovery image from valve, only repair_device.sh was modified) 
by running the following commands the following:

    sudo pacman -Sy
    sudo pacman -S git
    git clone https://github.com/Gakomi/steamdeckrecovery.git
    sudo chmod 775 steamdeckrecovery/*
    cd steamdeckrecovery/

Once you boot in to the livemedia mount the recovery usb and all the partitions on it.

For the script to work you need steamos-chroot 

To install it after you mounted the recovery usb run install-steamos-chroot.sh by using command 
     
     ./install-steamos-chroot.sh

After that run the recovery script you need in my case I wanted it restore to factory setting so I ran 
     
     ./factory_reimage.sh
     
Once the script finishes running console will shutdown you need to power it on. 
After it boots and you log in in to the syestem switch to desktop mode.
In desktop mode enter terminal and add a password using command:

      passwd

After that Disable read-only mode: 

     sudo btrfs property set -ts / ro false

Initialize keys:

     sudo pacman-key --init

Populate keys: 

     sudo pacman-key --populate archlinux
     
Once this is done if you use df -h you will see that the root partition has 5gb
If you use lsblk you will see that the partition is 20gb this issue is  do to the fac that the filesystem is 5gb while the partition is 20gb
In order to fix this you will need to run the following command:

     btrfs filesystem resize max /
     
     
     

Modifications done to repair_device.sh 

Lines:

    ${DISK}${DISK_SUFFIX}4: name="rootfs-A", size=  5120MiB, type=4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709
    
Was changed to
 
    ${DISK}${DISK_SUFFIX}4: name="rootfs-A", size= 20480MiB, type=4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709

This changes was done as I think 5gb is not enough space for root (I think rootfs-b is used as a backup so I did not change it)

    "rootdevice="$(findmnt -n -o source / )" 

Was changed to 

    "rootdevice="$(findmnt -n -o source /run/media/liveuser/rootfs)" 

and the following lines were removed:

    # Freeze our rootfs
    estat "Freezing rootfs"
    unfreeze() { fsfreeze -u /; }
    onexit+=(unfreeze)
    cmd fsfreeze -f /
    
 As this step I found it's unecessary and the script would not work with it anyway.
