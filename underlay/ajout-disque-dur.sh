#!/bin/bash
# Avant toute opération, voici l'affichage fdisk -l : 
export USER_LX_OPERATEUR=bobby
export NOUVEAU_DISQUE_DUR=/dev/sdb
# [sudo] password for bobby:
#
# Disk /dev/sda: 107.4 GB, 107374182400 bytes, 209715200 sectors
# Units = sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
# Disk label type: dos
# Disk identifier: 0x000bd1f5
#
#    Device Boot      Start         End      Blocks   Id  System
# /dev/sda1   *        2048     2099199     1048576   83  Linux
# /dev/sda2         2099200   209715199   103808000   8e  Linux LVM
# 
# Disk /dev/mapper/centos-root: 53.7 GB, 53687091200 bytes, 104857600 sectors
# Units = sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
#
# Disk /dev/mapper/centos-swap: 8455 MB, 8455716864 bytes, 16515072 sectors
# Units = sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
# 
# 
# Disk /dev/mapper/centos-home: 44.1 GB, 44149243904 bytes, 86228992 sectors
# Units = sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes


# J'ai arrêté la VM, ai jouté un disque dur à la VM, pendant qu'elle est arrêtée, puis ai redémarré la VM : 

# sudo fdisk -l
# 
# Disk /dev/sda: 107.4 GB, 107374182400 bytes, 209715200 sectors
# Units = sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
# Disk label type: dos
# Disk identifier: 0x000bd1f5
# 
#    Device Boot      Start         End      Blocks   Id  System
# /dev/sda1   *        2048     2099199     1048576   83  Linux
# /dev/sda2         2099200   209715199   103808000   8e  Linux LVM
# 
# Disk /dev/sdb: 107.4 GB, 107374182400 bytes, 209715200 sectors
# Units = sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
# 
# 
# Disk /dev/mapper/centos-root: 53.7 GB, 53687091200 bytes, 104857600 sectors
# Units = sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
# 
# 
# Disk /dev/mapper/centos-swap: 8455 MB, 8455716864 bytes, 16515072 sectors
# Units = sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
# 
# 
# Disk /dev/mapper/centos-home: 44.1 GB, 44149243904 bytes, 86228992 sectors
# Units = sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
# 
# 
# 

# --->>>>> Maintenant, on va créer une partition  sur le nouveau disque dur inséré. Cette unique partition occupera la totalité de la capacité du disque.
sudo fdisk $NOUVEAU_DISQUE_DUR 

# [bobby@pc-100 ops-underlay]$ sudo fdisk /dev/sdb
# [sudo] password for bobby: 
# Welcome to fdisk (util-linux 2.23.2).
# 
# Changes will remain in memory only, until you decide to write them.
# Be careful before using the write command.
# 
# Device does not contain a recognized partition table
# Building a new DOS disklabel with disk identifier 0x9e0dcc47.
# 
# Command (m for help): m
# Command action
#    a   toggle a bootable flag
#    b   edit bsd disklabel
#    c   toggle the dos compatibility flag
#    d   delete a partition
#    g   create a new empty GPT partition table
#    G   create an IRIX (SGI) partition table
#    l   list known partition types
#    m   print this menu
#    n   add a new partition
#    o   create a new empty DOS partition table
#    p   print the partition table
#    q   quit without saving changes
#    s   create a new empty Sun disklabel
#    t   change a partition's system id
#    u   change display/entry units
#    v   verify the partition table
#    w   write table to disk and exit
#    x   extra functionality (experts only)
# 
# Command (m for help): d
# No partition is defined yet!
# 
# Command (m for help): n
# Partition type:
#    p   primary (0 primary, 0 extended, 4 free)
#    e   extended
# Select (default p): p
# Partition number (1-4, default 1): 1
# First sector (2048-209715199, default 2048): 
# Using default value 2048
# Last sector, +sectors or +size{K,M,G} (2048-209715199, default 209715199): 
# Using default value 209715199
# Partition 1 of type Linux and of size 100 GiB is set
# 
# Command (m for help): w
# The partition table has been altered!
# 
# Calling ioctl() to re-read partition table.
# Syncing disks.
# [bobby@pc-100 ops-underlay]$ df -Th
# Filesystem              Type      Size  Used Avail Use% Mounted on
# /dev/mapper/centos-root xfs        50G   12G   39G  24% /
# devtmpfs                devtmpfs  3.9G     0  3.9G   0% /dev
# tmpfs                   tmpfs     3.9G     0  3.9G   0% /dev/shm
# tmpfs                   tmpfs     3.9G  9.2M  3.9G   1% /run
# tmpfs                   tmpfs     3.9G     0  3.9G   0% /sys/fs/cgroup
# /dev/mapper/centos-home xfs        42G  2.4G   39G   6% /home
# /dev/sda1               xfs      1014M  183M  832M  19% /boot
# tmpfs                   tmpfs     783M     0  783M   0% /run/user/1000
# [bobby@pc-100 ops-underlay]$ # sudo mkfs.ext4
# 
# [bobby@pc-100 ops-underlay]$ sudo mkfs.ext4 /dev/sdb
# [sudo] password for bobby: 
# mke2fs 1.42.9 (28-Dec-2013)
# /dev/sdb is entire device, not just one partition!
# Proceed anyway? (y,n) y
# Filesystem label=
# OS type: Linux
# Block size=4096 (log=2)
# Fragment size=4096 (log=2)
# Stride=0 blocks, Stripe width=0 blocks
# 6553600 inodes, 26214400 blocks
# 1310720 blocks (5.00%) reserved for the super user
# First data block=0
# Maximum filesystem blocks=2174746624
# 800 block groups
# 32768 blocks per group, 32768 fragments per group
# 8192 inodes per group
# Superblock backups stored on blocks: 
# 	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
# 	4096000, 7962624, 11239424, 20480000, 23887872
# 
# Allocating group tables: done                            
# Writing inode tables: done                            
# Creating journal (32768 blocks): done
# Writing superblocks and filesystem accounting information: done   
# 
# [bobby@pc-100 ops-underlay]$ 
# [bobby@pc-100 ops-underlay]$ df -Th
# Filesystem              Type      Size  Used Avail Use% Mounted on
# /dev/mapper/centos-root xfs        50G   12G   39G  24% /
# devtmpfs                devtmpfs  3.9G     0  3.9G   0% /dev
# tmpfs                   tmpfs     3.9G     0  3.9G   0% /dev/shm
# tmpfs                   tmpfs     3.9G  9.2M  3.9G   1% /run
# tmpfs                   tmpfs     3.9G     0  3.9G   0% /sys/fs/cgroup
# /dev/mapper/centos-home xfs        42G  2.4G   39G   6% /home
# /dev/sda1               xfs      1014M  183M  832M  19% /boot
# tmpfs                   tmpfs     783M     0  783M   0% /run/user/1000

sudo mkdir-p /infra-kytes
sudo chown -R $USER_LX_OPERATEUR /infra-kytes


#### ---->>>> Ok, donc on va monter ler nouveau disque dur de 100 Go, sur /carto
#### -------------->>>  dans /infra-kytes , il y aura la provision infra-kytes, et je pourrai plus tard monter un autre disque dur plus gros là dessus, et migrer l'infra-kytes dasn ce répertoire
#### -------------->>>  dans /carto/proto, il y aura le run de mon proto de carto
#### -------------->>>  dans /carto/vault, c là qu'il y aura tout ce qui est gros fichiers PBF
sudo mount $NOUVEAU_DISQUE_DUR /carto

df -Th
# Filesystem              Type      Size  Used Avail Use% Mounted on
# /dev/mapper/centos-root xfs        50G   12G   39G  24% /
# devtmpfs                devtmpfs  3.9G     0  3.9G   0% /dev
# tmpfs                   tmpfs     3.9G     0  3.9G   0% /dev/shm
# tmpfs                   tmpfs     3.9G  9.2M  3.9G   1% /run
# tmpfs                   tmpfs     3.9G     0  3.9G   0% /sys/fs/cgroup
# /dev/mapper/centos-home xfs        42G  2.4G   39G   6% /home
# /dev/sda1               xfs      1014M  183M  832M  19% /boot
# tmpfs                   tmpfs     783M     0  783M   0% /run/user/1000
# tmpfs                   tmpfs     783M     0  783M   0% /run/user/0
# /dev/sdb                ext4       99G   61M   94G   1% /carto
df -Th /carto
# Filesystem     Type  Size  Used Avail Use% Mounted on
# /dev/sdb       ext4   99G   61M   94G   1% /carto
# 
sudo chown -R $USER_LX_OPERATEUR /carto
sudo mkdir -p /carto/vault
sudo mkdir -p /carto/proto

# Le montage doit être autmatique au démarrage OS
echo " You must be root to complete next commands "
# I prefer 'sudo -s', such as I learned from éric levenez, my Master in Linux, instead of 'sudo -i', because 'sudo -s' expects and assumes less about the underlying linux instance.
sudo -s
echo "# disque dur prtotoype cartographie kytes " >> /etc/fstab
echo "$NOUVEAU_DISQUE_DUR   /carto   ext4   defaults    0    0" >> /etc/fstab




