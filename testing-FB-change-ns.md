## Features

### FB-change-ns

This branch adds a new module called islandora_change_namespace that provides a means to move an entire collection from one namespace to another via drush command.

#### Testing

See the module [README](https://github.com/lsulibraries/islandora_change_namespace) for usage. Note that normal ingest conditions still apply: you will need to publish the new collection and, in the likely event that your clone operation creates a new namespace, you will need to clear the cache so that namespace_homepage has a chance to rebuild the menu router links.