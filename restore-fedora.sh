#! /bin/bash

cd /usr/local/fedora/
service tomcat7 stop
mysql -uroot -proot fedora3 < /tmp/fedora/db.sql
rm -rf /usr/local/fedora/data/objectStore/* /usr/local/fedora/data/datastreamStore/*
mv /tmp/fedora/datastreamStore/* data/datastreamStore/
mv /tmp/fedora/objectStore/* data/objectStore/

export CATALINA_HOME=/var/lib/tomcat7
export FEDORA_HOME=/usr/local/fedora
sh server/bin/fedora-rebuild.sh
sh server/bin/fedora-rebuild.sh
chown -R tomcat7 data/resourceIndex/
service tomcat7 start
