## Features

### FB-change-ns

This branch adds a new module called islandora_change_namespace that provides a means to move an entire collection from one namespace to another via drush command.

#### Testing

This branch ingests the Camp Ruston collection because it contains both compound and simple objects. Test this feature from the command line under the web root. Check the options available for the command: `drush islandora_change_namespace_collection -h`. Here 

~~~

# clone the collection
drush -u 1 islandora_change_namespace_collection --pid=latech-cmprt:collection --new_pid=latech-cmprt-doppel:collection

# clone an item-  will still be isMemberOf the original collection
drush -u 1 islandora_change_namespace_item --pid=latech-cmprt:7 --new_pid=latech-cmprt-doppel:999

# clone an item, specifying the new parent collection - find it in the specified parent collection 
drush -u 1 islandora_change_namespace_item --pid=latech-cmprt:7 --new_pid=latech-cmprt-doppel:99 --parent=latech-cmprt-doppel:collection

# clone an item into a new parent - note that the original (--pid) is deleted
drush -u 1 islandora_change_namespace_item --pid=latech-cmprt:7 --new_pid=latech-cmprt-doppel:7799 --parent=latech-cmprt-doppel:collection --purge=1

# clone a collection, providing the --parent option - error and exit (currently...)
drush -u 1 islandora_change_namespace_collection --pid=latech-cmprt:collection --new_pid=latech-cmprt-ganger:collection --parent=latech-cmprt-doppel:collection 


# clone the collection with purge option - original will be gone
drush -u 1 islandora_change_namespace_collection --pid=latech-cmprt:collection --new_pid=latech-cmprt-survivor:collection --purge=9

~~~