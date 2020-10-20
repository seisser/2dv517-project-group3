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


echo "Update apt-cache"
sudo apt update > /dev/null 2>&1
echo "Upgrade system"
sudo apt -qy upgrade > /dev/null 2>&1
echo "Install various packages(ssh, python3 etc)"
sudo apt -y install aptitude build-essential git ntp ntpdate \
openssh-server python-dev python3-pip > /dev/null 2>&1
echo "Install ansible"
sudo apt -y install ansible > /dev/null 2>&1
echo "Install ansible-galaxy"
ansible-galaxy collection install openstack.cloud > /dev/null 2>&1
ansible-galaxy collection install nginxinc.nginx_core > /dev/null 2>&1
echo "install openstacksdk"
pip3 install openstacksdk > /dev/null 2>&1
echo "install prometheus and grafana"
ansible-galaxy install undergreen.prometheus-node-exporter
ansible-galaxy install cloudalchemy.prometheus
ansible-galaxy install cloudalchemy.grafana