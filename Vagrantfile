# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "500"
    vb.cpus = 1
  end

  config.vm.define :cantaloupe do |cantaloupe|
    cantaloupe.vm.box = "ubuntu/xenial64"
    cantaloupe.vm.network "private_network", ip: "192.168.222.4"
    cantaloupe.vm.network "forwarded_port", guest: 8182, host: 8182
    cantaloupe.vm.box_check_update = false
    cantaloupe.vm.provision "ansible" do |ansible|
      ansible.playbook = "cantaloupe.yml"
      ansible.verbose = 'vv'
      ansible.extra_vars = {
        ansible_python_interpreter: '/usr/bin/python3'
      }
    end
  end

  config.vm.define :solr do |solr|
    solr.vm.network "private_network", ip: "192.168.222.1"
    solr.vm.network "forwarded_port", guest: 8983, host: 8983
    solr.vm.box_check_update = false
    solr.vm.provider "virtualbox" do |vb|
      vb.memory = "1000"
      vb.cpus = 1
    end
    solr.vm.provision "ansible" do |ansible|
      ansible.playbook = "solr.yml"
      ansible.verbose = 'vv'
      ansible.extra_vars = {
        ansible_python_interpreter: '/usr/bin/python3'
      }
    end
  end

  config.vm.define :backend do |backend|
    backend.vm.box = "ubuntu/xenial64"
    backend.vm.network "private_network", ip: "192.168.222.3"
    backend.vm.network "forwarded_port", guest: 8080, host: 8080
    backend.vm.box_check_update = false
    backend.vm.provider "virtualbox" do |vb|
      vb.memory = "2000"
      vb.cpus = 1
    end
    backend.vm.provision "ansible" do |ansible|
      ansible.playbook = "backend.yml"
      ansible.verbose = 'vv'
      ansible.extra_vars = {
        ansible_python_interpreter: '/usr/bin/python3'
      }
    end
  end

  config.vm.define :frontend do |frontend|
    frontend.vm.box = "ubuntu/trusty64"
    frontend.vm.network "private_network", ip: "192.168.222.2"
    frontend.vm.network "forwarded_port", guest: 80, host: 8000
    frontend.vm.box_check_update = false

    frontend.vm.provider "virtualbox" do |vb|
      vb.memory = "2000"
      vb.cpus = 1
    end

    frontend.vm.provision "ansible" do |ansible|
      ansible.playbook = "frontend.yml"
      ansible.verbose = 'vv'
    end
  end
end
