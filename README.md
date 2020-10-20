# 2dv517-project-group3

Group project in 2dv517....


0. Add "- ./vars-etc/private-vars.yml" to the ansible-instance-up.yaml, otherwise it won't find the keyname.
1. Set your ssh-key name in vars-etc/private-vars.yml (no pathing or .pem in the end, only the name)
2. Set your ssh-key path in ansible.cfg (use path and .pem in the end, since this is full pathing)
3. Run network-up.yml and ansible-instance-up.yml.
4. SSH in to the Ansible instance
5. Run securitygroups-up.yml and infrastructure-up.yml
6. Create .config/openstack (mkdir -p .config/openstack)
7. Copy clouds.yaml to /home/ubuntu/.config/openstack/ (~/.config/openstack)
8. Copy ssh-key to /home/ubuntu/.ssh/ (~/.ssh)
9. Run Scripts/install-ansible.sh
10. Run Scripts/dynamic-inv-script-install.sh
11. Run Playbooks/initialize-inventory.yaml
