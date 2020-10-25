#! /bin/bash

tar -cvf project.tar.gz *
ansible-playbook Playbooks/external-playbooks/external-all-up.yml

ssh -tt -i ~/.ssh/acme-key.pem ubuntu@194.47.176.245 << EOF

ansible-playbook Playbooks/all-internal-infra-up.yml
ansible-playbook Playbooks/all-internal-software-up.yml

exit
EOF



