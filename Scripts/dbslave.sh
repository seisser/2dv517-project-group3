#! /bin/bash

# This is a script will create a new Database with user.
#
# Author: Renato Opazo Salgado, Anton, Linus

masterip=$1
mlogfile=$2
mlogpos=$3

sudo mysql --user=root <<_EOF_
        STOP SLAVE;
        CHANGE MASTER TO MASTER_HOST ='$masterip', MASTER_USER ='acme_user', MASTER_PASSWORD ='acme_password', MASTER_LOG_FILE = '$mlogfile', MASTER_LOG_POS = $mlogpos;
        START SLAVE;
_EOF_
