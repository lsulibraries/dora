#! /bin/bash

cd /usr/local/fedora/
service tomcat7 stop
rm -rf /tmp/fedora
mkdir -p /tmp/fedora/datastreamStore /tmp/fedora/objectStore
mysqldump -uroot -proot fedora3 > /tmp/fedora/db.sql
mv data/datastreamStore/* /tmp/fedora/datastreamStore/
mv data/objectStore/* /tmp/fedora/objectStore/

export CATALINA_HOME=/var/lib/tomcat7
export FEDORA_HOME=/usr/local/fedora
sh server/bin/fedora-rebuild.sh
sh server/bin/fedora-rebuild.sh
chown -R tomcat7 data/resourceIndex/
service tomcat7 start

cd /var/www/ldl
drush -u 1 islandora-solution-pack-install-required-objects --module=islandora --force
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_audio
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_basic_collection
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_basic_image
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_book
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_compound_object
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_disk_image
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_entities
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_large_image
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_newspaper
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_oh
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_pdf
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_solution_pack_remote_resource
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_scholar
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_video
drush -u 1 islandora-solution-pack-install-content_models --module=islandora_web_archive
drush -u 1 islandora-solution-pack-install-content_models --module=pmid_populator
drush -u 1 islandora-solution-pack-install-content_models --module=ris_populator
