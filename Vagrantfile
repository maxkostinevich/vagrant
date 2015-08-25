# -*- mode: ruby -*-
# vi: set ft=ruby :


# CONFIG

# IP ADDRESS
ip_address = "192.168.10.2"

# Synced folder path
synced_folder_path = "D:/work/www/"

# The project name, it will be used in hostname also
project_name = "demo"

#MYSQL password
mysql_password = "root"

#ssh_user = "root"
#ssh_password = "vagrant"

# END CONFIG

Vagrant.configure(2) do |config|

   config.vm.box = "ubuntu/trusty64"
   config.vm.hostname = "local." + project_name
   config.vm.network "forwarded_port", guest: 80, host: 8080
   config.vm.network "private_network", ip: ip_address #, name: "VirtualBox Host-Only Ethernet Adapter"
   
   #config.ssh.username = ssh_user
   #config.ssh.password = ssh_password
   #config.ssh.insert_key = 'true'
   #config.ssh.private_key_path = File.expand_path("../../vagrant-ppk-dev", __FILE__)

   config.vm.synced_folder synced_folder_path + project_name + "/", "/var/www/" + project_name + "/"


   config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
     vb.cpus = 2
   end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
   #config.vm.provision "shell", inline: <<-SHELL
   #  sudo apt-get update
   #  sudo apt-get install -y apache2
   #SHELL
   config.vm.provision :shell, path: "bootstrap.sh", :args => [ip_address, project_name, mysql_password]
end
