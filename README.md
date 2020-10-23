# 2dv517-project-group3

Group project in 2dv517....

0. Important: Download https://1drv.ms/u/s!ApGgBTqo-bpPinMw8UZs9PnkhMh5?e=BvpmBn and place it in the same folder as backup.sql, ansible.cfg, the project.tar.gz etc.    
1. Use a key named acme-key.pem, it is hardcoded in certain places.

2. Set your ssh-key name in vars-etc/private-vars.yml (no pathing or .pem in the end, only the name)
3. Set your ssh-key path in ansible.cfg (use path and .pem in the end, since this is full pathing)    

4. Set variables in:
5. vars-etc/ansible-setup-vars.yml (the ansible_server_ip should be the floating ip that openstack gives the first server created*)
6. also add the floating-ip which will be used for Ansibleserver1, in the vars-etc/inventory.yml**
7. Run external-all-up.yml    

8. ssh into the server
9. You might again have to update according to points 1 and 2 on the Ansibleserver1. 4 to 7 are only for the setup, from our own computers, of the Ansibleserver1.
10. Run Playbooks/all-internal-1-up.yml
11. Run Playbooks/all-internal-2-up.yml    


*To test if DB-replication works: ssh into Ansibleserver1 and from there ssh into DB_master then:
 Type "sudo mysql -u root"  and press enter, then type: "CREATE DATABASE acmedb;" and press enter, then type "SHOW DATABASES;" and press enter, you should now see acmedb in that list.
Now exit (go back to Ansibleserver1) and ssh into DB_slave then:
Type "sudo mysql -u root" and press enter, then type: "SHOW DATABASES;" and press enter, if you see acmedb in that list the replication works!


*When creating a new server, it seems as if openstack always uses the same floatingip first  
We need to use this ip for setting up the Ansibleserver1, since the inventory script is too buggy if not used from the Ansibleserver1. And in order to copy over various files we need an ip to copy to.  
**delete everything in the inventory and only add the floating ip for Ansibleserver1

Att göra om någon har lust:
1. fixa så allt går köra upp med ett script


Manual setup:
0. Setup from external location:
1. Network - Playbooks/(network-up.yml)
2. Security Groups - Playbooks/(security-groups-up.yml)
3. Ansibleserver1 - Playbooks/(ansible-instance-up -> copy-files-to-ansible.yml -> ansible.setup.yml)

0. Setup from internal location:
1. Instance Infrastructure - Playbooks(infrastructure-up.yml)
2. Install modules - Playbooks/(ansible-modules.yml)
3. Create dynamic inventory - Playbooks/(initialize-inventory.yml) 
4. Database replication - Playbooks/roles/(db.yml -> db-master.yml (-> dbmaster.sh) -> setup-acme-db.yml -> db-slave.yml (-> dbslave.sh))
5. Webservers - Playbooks/roles/(wordpress.yml)
6. Loadbalancing - Playbooks(NGINX-install.yml)
7. Monitoring - Playbooks/(prometheus-server-install.yml -> grafana-install.yml)

