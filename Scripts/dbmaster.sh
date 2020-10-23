#! /bin/bash

# This is a script will create a new Database with user.
#
# Author: Renato Opazo Salgado

slaveip=$1
web1=$2
web2=$3
web3=$4

sudo mysql --user=root <<_EOF_
        CREATE USER 'acme_user'@'$slaveip' IDENTIFIED BY '';
        GRANT REPLICATION SLAVE ON *.* TO 'acme_user'@'$slaveip';
        ALTER USER acme_user@$slaveip IDENTIFIED WITH mysql_native_password BY 'acme_password';
        CREATE USER 'wp'@'$web1' IDENTIFIED BY 'acme_password';
        CREATE USER 'wp'@'$web2' IDENTIFIED BY 'acme_password';
        CREATE USER 'wp'@'$web3' IDENTIFIED BY 'acme_password';
        GRANT ALL PRIVILEGES ON *.* TO 'wp'@'$web1';
        GRANT ALL PRIVILEGES ON *.* TO 'wp'@'$web2';
        GRANT ALL PRIVILEGES ON *.* TO 'wp'@'$web3';
        FLUSH PRIVILEGES;
_EOF_

sudo mysql -u root -e "SHOW MASTER STATUS\G" | grep 'File\|Position' | sed 's/^ *//' > masterstatus.yml
