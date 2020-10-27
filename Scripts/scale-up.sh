#! /bin/bash

# When running this script add the new servers id:nr "sh scale-up.sh 4"

nr=$1

ansible-playbook Playbooks/internal-playbooks/wp-scale-up.yml --extra-vars "server_nr=$nr"

ansible-playbook Playbooks/roles/wordpress.yml

ansible-playbook Playbooks/internal-playbooks/nginx-scaleup.yml
