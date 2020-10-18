echo "downloading dynamic_inventory.py"
wget https://raw.githubusercontent.com/ansible/ansible/stable-2.7/contrib/inventory/openstack_inventory.py
chmod +775 openstack_inventory.py
sed -i 's/python/python3.8/' openstack_inventory.py
mv openstack_inventory.py ../Playbooks

#OBS: för att skriptet ska funka måste clouds.yaml finnas på server i lämplig sökväg.

#Testa så funkar:
#ansible -i openstack_inventory.py all -m ping

#Få en lista med all openstack info, och skriv den till en fil:
#./openstack_inventory.py --list > "json-format-inventory.json"
#För att kunna sätta dynamiska ip-adresser till t.ex nginx playbook, så måste man få ut data från denna fil via ansibles json-funktionalitet

#Installera på server med t.ex namnet "Webserver1"
#Dock måste namnet "Webserver1" finnas definierat i playbooken under kommandot "hosts", se nedan exempel(1)
#ansible-playbook -i ./openstack_inventory.py Playbooks/någonplaybook
 

#1.
#---
#- name: Setting up infrastructure for, and installing/configuring, Wordpress
#  remote_user: ubuntu
#  become: true
#  hosts: Webserver1
#  vars_files:
#    - ../vars-etc/wordpress-apache-php.yaml
