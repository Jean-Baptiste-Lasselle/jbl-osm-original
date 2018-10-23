#!/bin/bash
# set-underneath-vm-overcomit-config.sh
# Attention mon poulet, il faut être arcine des Ents, pour faire ce genre de trucs, okay?
echo "Attention mon poulet, il faut être racine des Ents, pour faire ce genre de trucs, okay?"
echo "# Overcommit settings to allow faster osm2pgsql imports"
sudo tee /etc/sysctl.d/60-overcommit.conf <<EOF
vm.overcommit_memory=1
EOF
sudo sysctl -p /etc/sysctl.d/60-overcommit.conf
