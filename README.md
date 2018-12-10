## Dora dev box

This vagrant/ansible project provides a minimal development environment for Louisiana Digital Library (LDL) developers. Clone and vagrant up; then vagrant ssh or login at localhost:8000 with admin:admin.

[tldr](#migration)- make changes and commit to a new branch

tldr*2 If you just want the box with collections, edit 'group_vars/all.yml' so that the variable `ingest_sample_collections: ` is `yes` instead of `no`.


### Box

The box referenced in the Vagrantfile is a custom base box built from the [full ansible play](https://github.com/lsulibraries/islandora_ansible).

### Role

This project is a sparse example of [Ansible best practices](http://docs.ansible.com/ansible/latest/playbooks_best_practices.html) that includes a skeleton role (`roles/dev`) mirroring the structure of the [final role](https://github.com/lsulibraries/ansible-role-islandora-local) in the base project.  The structure is intended to group changes into logical sets of tasks, as will be described. Because they share structure, it is simple to move changes from this project back into the base project where they can be included in future versions of this box.

As this is only a skeleton of a role, running it, through `vagrant up` and subsequently through `vagrant provision` will do very little beyond what is described in `finish.yml`: restart tomcat, revert all drupal features, and clear the drupal cache.

#### Role Structure - Tasks

The tasks of the role `roles/dev/tasks/`, are organized into files named for logical groupings as follows:

1. [system.yml](roles/dev/tasks/system.yml)
1. [modules.yml](roles/dev/tasks/modules.yml)
1. [vsets.yml](roles/dev/tasks/vsets.yml)
1. [roles-permissions.yml](roles/dev/tasks/roles-permissions.yml)
1. [content.yml](roles/dev/tasks/content.yml)
1. [dev.yml](roles/dev/tasks/dev.yml)
1. [finish.yml](roles/dev/tasks/finish.yml)
1. [sample-collections.yml](roles/dev/tasks/sample-collections.yml)

Each file comes with some descriptive comment at the top in addition to some sample tasks that you can copy and adapt as needed.

#### Task order

The order of these groupings is defined in `tasks/main.yml` and intended to ensure that changes to the underlying system happen before updates to drupal modules, which happen before setting variables, roles or permissions that might rely on those modules.

#### Role Structure - Variables

Most changes to the build can be made by updating the values of the variables defined in `group_vars/all.yml`.

Following [Ansible best practices](http://docs.ansible.com/ansible/latest/playbooks_best_practices.html), this project defines a top-level playbook,`build.yml`, that invokes a role (`roles/dev`) which assigns default values to variables (`roles/dev/defaults/main.yml`) which are overridden in `group_vars/all.yml`. All that to say that changes to ansible variables need to be made in `group_vars/all.yml` to be certain of affecting the build tasks.

Ansible variables are used in this project to define lists, primarily. Lists of:

- islandora module versions to clone
- lists of drupal modules to download/enable/disable/uninstall
- lists of drupal roles to create and permissions to add/remove
- lists of drupal variable keys and the values to assign

When you first clone this repo, most of these list variables will be set to the empty list `[]` so that the tasks that use them are skipped entirely. To enable such a task, update the variable assignment so that it gets a non-empty list; in all cases, example list items are provided, commented out. For example:

change

    drush_vset_simple: []
    # drush_vset_simple:
    # - { key: theme_default, value: ldl }
    # - { key: islandora_basic_collection_admin_page_size, value: 50 }

to a non-empty list:

    # drush_vset_simple: []
    drush_vset_simple:
    - { key: theme_default, value: ldl }
    - { key: islandora_basic_collection_admin_page_size, value: 50 }

In the preceding example, the empty version of the variable assignment gets commented out, and now the variable evaluates to a list of two items which will result in the drupal/islandora variables `theme_default` and `islandora_basic_collection_admin_page_size` being assigned their `value:` elements when the following task block is evaluated during the ansible run (invoked via `vagrant provision`):

    - name: Set simple key => val variables.
      command: drush -u 1 vset {{ item.key }} {{ item.value }}
      args:
        chdir: "{{ drupal_core_path }}"
      with_items: "{{ drush_vset_simple }}"

### Optional build steps
The following tasks are optional, and they are skipped or not based on the value of variables in `all.yml`.

#### Ingest sample collections

Installs a prepared set of sample collections. See sample-collections.yml for the list. NB that these ingest packages are held in an lsulibraries' s3 bucket which is ip restricted, so be sure you are on the LSU wired or wireless network.

#### Run dev steps

INCOMPLETE -

If you need to attach to this box with a debugger, analyze the app with xhprof, or similar, update the variable `run_dev_steps` to be true/yes. (more features coming soon).

##### behat
The [drupalextension](https://github.com/jhedstrom/drupalextension) project will be installed, by default at /opt/drupalextension. LDL tests will be cloned into a subdirectory of the drupalextension location.

In addition, selenium and chrome driver will be downloaded to /vagrant so as to be available on both the host and the guest OS. On the guest (the dora vagrant box), run selenium with `java -jar /vagrant/selenium-server-standalone-3.13.0.jar -role hub` On the host, be sure that chromedriver is in your $PATH, then run `java -jar selenium-server-standalone-3.13.0.jar -role node -hub http://192.168.111.111:4444/grid/register/`.

With that done, you are all set up to run behat tests. From /opt/drupalextension/ldl_behat, run `behat`; you should see the entire test suite begin to run in a chrome browser on your host OS. Use `@tags` to limit the tests that will be run: `behat --tags @islandora_elide_download`.
