# 2dv517-project-group3

Group project in 2dv517....

0. Important: Download https://1drv.ms/u/s!ApGgBTqo-bpPinTEVeUcxCJvIkVg?e=pnmTcc and place it in the same folder as backup.sql, ansible.cfg, etc.    
1. Now, from inside folder with the backup.sql, ansible.cfg etc, run "tar -cvf project.tar.gz *", which creates a project.tar.gz which will be uploaded to Ansibleserver1.
2. Use a key named acme-key.pem, it is hardcoded in 2-3 places.

3. Set your ssh-key name in vars-etc/private-vars.yml (no pathing or .pem in the end, only the name)
4. Set your ssh-key path in ansible.cfg (use path and .pem in the end, since this is full pathing)    

5. Set variables in:
6. vars-etc/ansible-setup-vars.yml (the ansible_server_ip should be the floating ip that openstack gives the first server created[1])
7. also add the floating-ip which will be used for Ansibleserver1, in the vars-etc/inventory.yml[2]
8. Run external-all-up.yml    

9. ssh into the server
10. You shouldn't have to, but might have to update according to points 1 and 2 also on the Ansibleserver1. 5 to 8 are only for the setup, from our own computers, of the Ansibleserver1.
11. Run Playbooks/all-internal-infra-up.yml
12. Run Playbooks/all-internal-software-up.yml    


*To test if DB-replication works: ssh into Ansibleserver1 and from there ssh into DB_master then:
 Type "sudo mysql -u root"  and press enter, then type: "CREATE DATABASE acmedb;" and press enter, then type "SHOW DATABASES;" and press enter, you should now see acmedb in that list.
Now exit (go back to Ansibleserver1) and ssh into DB_slave then:
Type "sudo mysql -u root" and press enter, then type: "SHOW DATABASES;" and press enter, if you see acmedb in that list the replication works!

*To use volume first time(Default usecase is for DB_master, change this in the mount-server-vars.yml if you want):
1. create-volume.yml
2. create-mount-point.yml (will also make the volume ext4)
3. create-database-backup (attaches, copies database, detaches)
4. attach-and-mount.yml, ssh into DB_master, run (ls /tmp/vol/) to check that the backup was successful
5. umount-and-detach.yml when finished

*To use volume continously:
1. create-database-backup.yml


[1]When creating a new server, it seems as if openstack always uses the same floatingip first  
We need to use this ip for setting up the Ansibleserver1, since the inventory script is too buggy if not used from the Ansibleserver1. And in order to copy over various files we need an ip to copy to.  
[2]delete everything in the inventory and only add the floating ip for Ansibleserver1


Step-by-step setup(1-3 from external location. 4-10 from Ansibleserver1):
1. Network - Playbooks/(network-up.yml)
2. Security Groups - Playbooks/(security-groups-up.yml)
3. Ansibleserver1 - Playbooks/(ansible-instance-up -> copy-files-to-ansible.yml -> ansible.setup.yml)
4. Instance Infrastructure - Playbooks(infrastructure-up.yml)
5. Install modules - Playbooks/(ansible-modules.yml)
6. Create dynamic inventory - Playbooks/(initialize-inventory.yml) 
7. Database replication - Playbooks/roles/(db.yml -> db-master.yml (-> dbmaster.sh) -> setup-acme-db.yml -> db-slave.yml (-> dbslave.sh))
8. Webservers - Playbooks/roles/(wordpress.yml)
9. Loadbalancing - Playbooks(NGINX-install.yml)
10. Monitoring - Playbooks/(prometheus-server-install.yml -> grafana-install.yml)

