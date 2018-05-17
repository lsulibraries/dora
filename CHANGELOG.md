# Changelog

using [Semantic Versioning 2.0.0 (2018-03-13)](https://semver.org/):

>Given a version number MAJOR.MINOR.PATCH, increment the:

>  - MAJOR version when you make incompatible API changes,

>  - MINOR version when you add functionality in a backwards-compatible manner, and
>  - PATCH version when you make backwards-compatible bug fixes.

## 0.10.0
*item 2.0 in progress*

This release adds theme changes bringing book and large image into line with *item 2.0*.


## 0.9.0
*loose-ends*

This release pulls in a number of changes that have been hanging around in the dev sphere since the winter holidays.

- **Theme**: adds new Compound object display for both desktop and mobile
- **drupal updates**: to drupal core and contrib (non-islandora) modules
- **islandora version update**: to version 7.x-1.10
- **Book**: sets viewer default to 'two-up'
- **Book**: sets book level object metadata to display
- **Change Namespace**: new module to clone a collection from one namespace to another
- **libcurl**: updates OS curl version to overcome intermittent errors in operating the 'change namespace' module
- **solr changes**
- **title/subtitle display**
- **book_access**: ensures unsupported drupal contrib module is disabled
- **IP embargo**: adds support for passthru of multiple image servers; adds debug logging
- **pdfjs**: retires lsulibraries fork, [PR accepted](https://github.com/Islandora/islandora_pdfjs/pull/25), also [in JIRA](https://jira.duraspace.org/browse/ISLANDORA-2157)
- **PDF solution pack**: retires lsulibraries fork by moving local override into theme templates/ https://github.com/lsulibraries/dora/commit/f903afbbe90b6788416a895e463f96fa5926e4f4

## 0.8.1

*winter hustle*

- updates to the dora dev box ingest machinery
- adds LSU fork of Remote Resource solution pack to facilitate OAI harvesting of Tulane collections
- bugfix for the namespaced search feature
- adds logo for vville, updates ull logo
- system admin utilities improvements for finding datastreams, creating collections
- updates seadragon viewer default zoom
- mods display updates

for previous versions, (for now) see tags and project history in https://github.com/lsulibraries/islandora_ansible
