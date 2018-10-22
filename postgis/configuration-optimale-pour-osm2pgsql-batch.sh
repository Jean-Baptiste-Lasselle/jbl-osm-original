#!/bin/bash
# Attention mon poulet, dans le Dockerfile, il faut être rcine des Ents, pour faire ce genre de trucs, okay?
echo "# Overcommit settings to allow faster osm2pgsql imports"
tee /etc/sysctl.d/60-overcommit.conf <<EOF
vm.overcommit_memory=1
EOF
sysctl -p /etc/sysctl.d/60-overcommit.conf
