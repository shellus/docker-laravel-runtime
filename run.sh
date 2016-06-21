#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

if [[ ! -d ${VOLUME_HOME}/mysql ]]; then
    echo "=> An empty or uninitialized MariaDB volume is detected in $VOLUME_HOME"
    echo "=> Installing mysql_install_db ..."
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"
else
    echo "=> Using an existing volume of MariaDB"
fi

exec /usr/local/bin/supervisord -c /etc/supervisord.conf
