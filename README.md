# 2dv517-project-group3

Group project in 2dv517....


0. Add "- ./vars-etc/private-vars.yml" to the ansible-instance-up.yaml, otherwise it won't find the keyname.
1. Set your ssh-key name in vars-etc/private-vars.yml (no pathing or .pem in the end, only the name)
2. Set your ssh-key path in ansible.cfg (use path and .pem in the end, since this is full pathing)
3. Run network-up, ansible-instance-up, infrastructure-up.
4. SSH in to the Ansible instance
5. Create .config/openstack (mkdir -p .config/openstack)
6. Copy clouds.yaml to /home/ubuntu/.config/openstack/ (~/.config/openstack)
7. Copy ssh-key to /home/ubuntu/.ssh/ (~/.ssh)
8. Run Scripts/install-ansible.sh
9. Run Scripts/dynamic-inv-script-install.sh
10. Run Playbooks/initialize-inventory.yaml
