# 2dv517-project-group3

Group project in 2dv517....

1. Set your ssh-key name in vars-etc/private-vars.yml (no pathing or .pem in the end, only the name)
2. Set your ssh-key path in ansible.cfg (use path and .pem in the end, since this is full pathing)  

3. Set variables in:
4. vars-etc/ansible-setup-vars.yml (the ansible_server_ip should be the floating ip that openstack gives the first server created*)
5. also add the floating-ip which will be used for Ansibleserver1, in the vars-etc/inventory.yml**
6. Run ansible-instance-up.yml  

7. ssh into the server
8. You will again have to update according to points 1 and 2 on the Ansibleserver1. 3 to 6 are only for the setup, from our own computers, of the Ansibleserver1.
9. Run Playbooks/infrastructure-up.yml
10. Run Playbooks/initialize-inventory.yml

For db:

11. Run Playbooks/roles/db.yml

12. Run Playbooks/roles/db-master.yml

13. Run Playbooks/roles/db-slave.yml

*To test if this work: ssh into Ansibleserver1 and from there ssh into DB_master then:
 Type "sudo mysql -u root"  and press enter, then type: "CREATE DATABASE acmedb;" and press enter, then type "SHOW DATABASES;" and press enter, you should now see acmedb in that list.
Now exit (go back to Ansibleserver1) and ssh into DB_slave then:
Type "sudo mysql -u root" and press enter, then type: "SHOW DATABASES;" and press enter, if you see acmedb in that list the replication works!


*When creating a new server, it seems as if openstack always uses the same floatingip first  
We need to use this ip for setting up the Ansibleserver1, since the inventory script is too buggy if not used from the Ansibleserver1. And in order to copy over various files we need an ip to copy to.  
**delete everything in the inventory and only add the floating ip for Ansibleserver1
