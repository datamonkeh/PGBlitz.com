#!/bin/bash

## For Google Drive
clear

rclone config

# disable the unencrypted services to prevent a clash
systemctl stop rclone
systemctl stop move
systemctl disable rclone
systemctl disable move

# stop current services
systemctl stop unionfs
systemctl stop unionfs-encrypt
systemctl stop rclone-en
systemctl stop rclone-encrypt
systemctl stop move-en

# copy rclone config from sudo user to root, which is the target
cp ~/.config/rclone/rclone.conf /root/.config/rclone/

# ensure that the encrypted services are on
systemctl enable rclone-en
systemctl enable rclone-encrypt
systemctl enable move-en

# turn services back on
systemctl start unionfs-encrypt
systemctl start rclone-en
systemctl start rclone-encrypt
systemctl start move-en

######################### REPEATS TO MAKE IT WORK
# disable the unencrypted services to prevent a clash
systemctl stop rclone
systemctl stop move
systemctl disable rclone
systemctl disable move

# stop current services
systemctl stop unionfs
systemctl stop unionfs-encrypt
systemctl stop rclone-en
systemctl stop rclone-encrypt
systemctl stop move-en

# copy rclone config from sudo user to root, which is the target
cp ~/.config/rclone/rclone.conf /root/.config/rclone/

# ensure that the encrypted services are on
systemctl enable rclone-en
systemctl enable rclone-encrypt
systemctl enable move-en

# turn services back on
systemctl start unionfs-encrypt
systemctl start rclone-en
systemctl start rclone-encrypt
systemctl start move-en

# set variable to remember what version of rclone user installed
mkdir -p /var/plexguide/rclone 1>/dev/null 2>&1
touch /var/plexguide/rclone/en 1>/dev/null 2>&1
rm -r /var/plexguide/rclone/un

clear
cat << EOF
NOTE: You installed the encrypted version for the RClone data transport! If you
messed anything up, select [3] and run through again.  Also check:
http://enrclone.plexguide.com and or post on http://reddit.plexguide.com

HOW TO CHECK: In order to check if everything is working, have 1 item at least
in your google Drive

1. Type: /mnt/gdrive (and then you should see some item from your g-drive there)
2. Type: /mnt/unionfs (and you should see the same g-drive stuff there)

Verifying that 1 and 2 are important due to this is how your data will sync!

To make this easy, you can also use the checking tools built in!

EOF
bash /opt/plexguide/scripts/docker-no/continue.sh
