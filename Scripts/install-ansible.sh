#! /bin/bash

# This script will update and upgrade The OS and install Ansible.
#
# Author: Renato Opazo Salgado
# Date: 2020-10-05

# This checks are from the servisys ispconfig_setup installation file
if [[ "$#" -ne 0 ]]; then
	echo -e "Usage: sudo $0" >&2
	exit 1
fi

# Check if user is root
if [[ $(id -u) -ne 0 ]]; then # $EUID
	echo -e "Error: This script must be run as root, please run this script again with the root user or sudo." >&2
	exit 1
fi

# Check if on Linux
if ! echo "$OSTYPE" | grep -iq "linux"; then
	echo -e "Error: This script must be run on Linux." >&2
	exit 1
fi

apt update
apt -qy upgrade
apt -qy install ufw
apt-get -y install ntp ntpdate
ufw allow ssh
ufw enable

cd /var
touch swap.img
chmod 600 swap.img
dd if=/dev/zero of=/var/swap.img bs=1024k count="$SWAP_CUSTOM_SIZE"
mkswap /var/swap.img
swapon /var/swap.img
echo "/var/swap.img    none    swap    sw    0    0" >> /etc/fstab
cd ~/
sysctl -w vm.swappiness=30