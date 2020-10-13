#! /bin/bash

# This script will update and upgrade The OS and install Ansible.
# Following the docs from:
# https://docs.openstack.org/project-deploy-guide/openstack-ansible/ocata/deploymenthost.html
#
# Transfer this script to your server.
# scp -i ~/.ssh/[KEY_NAME] [PATH TO SCRIPT]/install-ansible.sh ubuntu@[SERVER IP]:~/
#
# Author: Renato Opazo Salgado
# Date: 2020-10-05



sudo apt update
sudo apt -qy upgrade
sudo apt -y install aptitude build-essential git ntp ntpdate \
openssh-server python-dev python3-pip sudo
sudo apt -y install ansible

ansible-galaxy collection install openstack.cloud
ansible-galaxy collection install nginxinc.nginx_core
pip3 install openstacksdk
