#! /bin/bash
#Because of some problem with the information propagation from the dynamic inventory when running all the playbooks in a single play, we have to do like this

tar -cvf project.tar.gz *
ansible-playbook Playbooks/external-playbooks/external-all-up.yml
ansible-playbook Playbooks/external-playbooks/copy-files-to-ansible.yml
ansible-playbook Playbooks/external-playbooks/ansible-setup.yml

test=$(grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' Playbooks/vars-etc/inventory.yml)
echo $test

ssh -tt -i ~/.ssh/acme-key.pem ubuntu@$test << EOF

ansible-playbook Playbooks/internal-playbooks/all-internal-infra-up.yml
ansible-playbook Playbooks/internal-playbooks/all-internal-software-up.yml

exit
EOF

rm project.tar.gz



