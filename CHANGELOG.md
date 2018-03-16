# Changelog

from [Semantic Versioning 2.0.0 (2018-03-13)](https://semver.org/):

>Given a version number MAJOR.MINOR.PATCH, increment the:

>  - MAJOR version when you make incompatible API changes,

>  - MINOR version when you add functionality in a backwards-compatible manner, and
>  - PATCH version when you make backwards-compatible bug fixes.


## 0.9.0
*loose-ends*

This release pulls in a number of changes that have been hanging around in the dev sphere since the winter holidays.

- **Theme**: adds new Compound object display for both desktop and mobile
- **Newspaper** solution pack: updates to latest from islandora
- **Book**: configures metadata display; sets viewer default to 'two-up'
- **Change Namespace**: new module to clone a collection from one namespace to another
- **libcurl**: updates OS curl version to overcome intermittent errors in operating the 'change namespace' module
- **solr changes**
- **title/subtitle display**
- **book_access**: ensures unsupported module is disabled
- **IP embargo**: adds support for passthru of multiple image servers; adds debug logging

## 0.8.1

*winter hustle*

- updates to the dora dev box ingest machinery
- adds LSU fork of Remote Resource solution pack to facilitate OAI harvesting of Tulane collections
- bugfix for the namespaced search feature
- adds logo for vville, updates ull logo
- system admin utilities improvements for finding datastreams, creating collections
- updates seadragon viewer default zoom
- mods display updates
