#! /bin/bash

ansible-playbook Playbooks/external-all-up.yml

ssh -tt -i ~/.ssh/acme-key.pem ubuntu@194.47.177.13 << EOF

ansible-playbook Playbooks/all-internal-infra-up.yml
ansible-playbook Playbooks/all-internal-software-up.yml

exit
EOF



