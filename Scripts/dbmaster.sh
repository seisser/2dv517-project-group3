#! /bin/bash

# This is a script will create a new Database with user.
#
# Author: Renato Opazo Salgado

slaveip=$1

sudo mysql --user=root <<_EOF_
        CREATE USER 'acme_user'@'$slaveip' IDENTIFIED BY 'acme_password';
        GRANT REPLICATION SLAVE ON *.* TO 'acme_user'@'$slaveip';
        ALTER USER acme_user$slaveip IDENTIFIED WITH mysql_native_password BY 'acme_password';
_EOF_

sudo mysql -u root -e "SHOW MASTER STATUS\G" | grep 'File\|Position' | sed 's/^ *//' > masterstatus.yml
