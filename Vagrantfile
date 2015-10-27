# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

dir = File.dirname(File.expand_path(__FILE__))

configValues = YAML.load_file("#{dir}/config.yaml")
data = configValues['vagrantfile-local']

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "#{data['vm']['box']}"

  config.vm.hostname = "#{data['vm']['hostname']}"

  if Vagrant.has_plugin?('vagrant-hostsupdater')
    config.hostsupdater.aliases = [
      "www.tapioca.dev",
      "api.tapioca.dev",
    ]
  end

  config.vm.synced_folder "./provision/sites-enabled/", "/etc/nginx/sites-enabled/", type: 'nfs'
  config.vm.synced_folder "./provision/etc/", "/vagrant/etc/", type: 'nfs'
  config.vm.synced_folder "#{data['vm']['htdocs']}", "/var/www/tapioca.dev/", id: "vagrant-id", type: 'nfs'

  config.vm.network 'private_network', ip: "192.168.57.152"
  config.vm.network :forwarded_port, guest: 22, host: 9678
  config.vm.network "forwarded_port", guest: 27017, host: 27017

  config.vm.usable_port_range = (10200..10500)

  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'
  config.ssh.keep_alive = true
  config.ssh.forward_agent = true
  config.ssh.insert_key = false

  config.vm.provision :shell, path: "./provision/install.sh", run: "once"
  config.vm.provision :shell, path: "./provision/start.sh", run: "always"

  # If you want an auto update on startup
  # config.vm.provision :shell, path: "./provision/auto_update.sh", run: "always"

  config.vm.provider :virtualbox do |virtualbox|
    virtualbox.customize ['modifyvm', :id, "--natdnshostresolver1", "on"]
    virtualbox.customize ['modifyvm', :id, '--memory', "#{data['vm']['memory']}"]
    virtualbox.customize ['modifyvm', :id, '--cpus', "1"]
    virtualbox.customize ['modifyvm', :id, '--name', config.vm.hostname]
  end
end
