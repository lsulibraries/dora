# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.define :dora do |dora|
    dora.vm.box = "dora"
    dora.vm.box_url = 'https://s3-us-west-2.amazonaws.com/lsulibraries-vagrant-boxes/dora.json'
    dora.vm.box_version = '1.1.0'
    dora.vm.box_download_checksum_type = 'sha256'
    dora.vm.box_download_checksum = '64afbfa1e9133f9d4cc3184ed6ab925c709b76828daaa49a566b426bd7261cbc'

    dora.vm.network "forwarded_port", guest: 80, host: 8000
    dora.vm.network "forwarded_port", guest: 8080, host: 8080
    dora.vm.network "private_network", ip: "192.168.111.111"
    dora.vm.provider "virtualbox" do |vb|
      vb.memory = "4000"
      vb.cpus = 1
    end

    # Use rbconfig to determine if we're on a windows host or not.

    require 'rbconfig'
    is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)
    if is_windows
      dora.vm.provision "ansible_local" do |ansible|
        ansible.playbook = "build.yml"
        ansible.verbose = 'vv'
        ansible.install = true
        ansible.extra_vars = {
          mysql_local_installation: "true",
          attach_mounts: false,
          drupal_reverse_proxy: false,
          fqdn_suffix: 'library.local'
        }
      end
    else
      dora.vm.provision "ansible" do |ansible|
        ansible.playbook = "build.yml"
        ansible.verbose = 'vv'
        ansible.extra_vars = {
          mysql_local_installation: "true",
          attach_mounts: false,
          drupal_reverse_proxy: false,
          fqdn_suffix: 'library.local'
        }
      end
    end
  end
  config.vm.define :solr do |solr|
    solr.vm.box = 'ubuntu/xenial64'
    solr.vm.network "forwarded_port", guest: 8983, host: 8983
    solr.vm.network "private_network", ip: "192.168.111.112"
    solr.vm.provider "virtualbox" do |vb|
      vb.memory = "4000"
      vb.cpus = 1
    end
    config.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y tree htop emacs default-jre
      cd /tmp/
      curl -OL http://archive.apache.org/dist/lucene/solr/5.5.5/solr-5.5.5.tgz
      tar -xzvf solr-5.5.5.tgz
      ./solr-5.5.5/bin/install_solr_service.sh /tmp/solr-5.5.5.tgz
    SHELL
  end
  config.vm.define :solr4 do |solr4|
    solr4.vm.box = 'ubuntu/xenial64'
    solr4.vm.network "forwarded_port", guest: 8983, host: 8983
    solr4.vm.network "private_network", ip: "192.168.111.113"
    solr4.vm.provider "virtualbox" do |vb|
      vb.memory = "4000"
      vb.cpus = 1
    end
    solr4.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y tree htop emacs default-jre
      cd /tmp/
      curl -OL http://archive.apache.org/dist/lucene/solr/4.10.4/solr-4.10.4.tgz
    SHELL
  end
end
