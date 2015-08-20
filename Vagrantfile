# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #
  # Configure VirtualBox Provider
  #
  config.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
  end

  #
  # Centos
  #

  config.vm.define "centos-5.11", autostart: false do |v|
    v.vm.box = "puppetlabs/centos-5.11-64-puppet"
    v.vm.hostname = "centos-5.11"
  end

  config.vm.define "centos-6.6", autostart: false do |v|
    v.vm.box = "puppetlabs/centos-6.6-64-puppet"
    v.vm.hostname = "650657-db3"
  end

  config.vm.define "centos-7.0", autostart: false do |v|
    v.vm.box = "puppetlabs/centos-7.0-64-puppet"
    v.vm.hostname = "centos-7-0"
  end

  #
  # Ubuntu
  #

  config.vm.define "ubuntu-12.04", autostart: false do |v|
    v.vm.box = "puppetlabs/ubuntu-12.04-64-puppet"
    v.vm.hostname = "ubuntu-12-04"
  end

  config.vm.define "ubuntu-14.04", autostart: false do |v|
    v.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
    v.vm.hostname = "ubuntu-14-04"
  end

  #
  # Windows
  #
  config.vm.define "windows-2012-standard", autostart: false do |v|
    v.vm.box = "opentable/win-2012-standard-amd64-nocm"
    # Name shortened due to limitation of Windows
    v.vm.hostname = "win-serv-2012-r2"
    v.vm.communicator = "winrm"
    v.vm.network "forwarded_port", guest: 3389, host: 3389
  end

  #
  # Add the required puppet modules before provisioning is run by puppet
  #
  config.vm.provision :shell do |shell|
     shell.inline = "puppet module install puppetlabs-stdlib;
                     puppet module install puppetlabs-apt;
                     puppet module install boundary-boundary;
                     exit 0"
  end

  #
  # Use Puppet to provision the server and setup an elastic search cluster
  # on a single box
  #
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
    puppet.facter = {
      "boundary_api_token" => ENV["BOUNDARY_API_TOKEN"]
    }
  end

end
