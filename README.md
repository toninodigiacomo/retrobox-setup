retrobox-setup
==============

I first did a kind of tutorial as a personal checklist while configuriny one of my Raspberry Pi. Then I found RetroPie, which is super but doesn't fit totally to my needs. So I decided to build those bash scripts for the automation of my needs.

The script is designed to be run through an SSH connexion.
If this error appears for the connection, then the solution is to edit the file "known_hosts" and to remove the ligne with the IP of the target:
nano /Users/[UserID]/.SSH/known_hosts

System:
-------
raspbian wheezy v.06-2014

Copy the image on the SD:
-------------------------
diskutil list
diskutil umountDisk /dev/disk1 (<-- if the SD is the "disk1")
SUDO dd if=[PATH]/2014-06-wheezy-raspbian.img of=/dev/disk1 (<-- if the SD is the "disk1")

Whezzy configuration:
---------------------
sudo raspi-config
1
sudo reboot
sudo raspi-config
4
I1
fr_CH.UTF-8 UTF-8
sudo reboot
4
I2
I3
7
High   950MHz ARM, 250MHz core, 450MHz SDRAM, 6 overvolt
8
A7
sudo reboot

Autologin:
----------
sudo nano /etc/inittab
Comment the line "1:2345:respawn:/sbin/getty --noclear 38400 tty1"
Add the new line "1:2345:respawn:/bin/login -f pi tty1 </dev/tty1 >/dev/tty1 2>&1"

Auto hide system startup messages:
----------------------------------
sudo nano /boot/cmdline.txt
Comment the existing line and add the new line:
"dwc_otg.lpm_enable=0 console=ttyAMA0,115200 kgdboc=ttyAMA0,115200 console=tty3 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline rootwait loglevel=3"
