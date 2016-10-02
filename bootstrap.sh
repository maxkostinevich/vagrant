#!/usr/bin/env bash

# create /public/ dir
sudo mkdir "/var/www"

# You'd neeed to install the Docker manually and apply the following:
# sudo usermod -aG docker vagrant

# update / upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# install bzip2
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install bzip2

#install vim
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install vim

#install curl
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install curl libcurl3 libcurl3-dev 

#install ping
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install iputils-ping

#install php
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install php7.0 php7.0-fpm php7.0-mysql

# install git
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install git
# install svn
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install libserf-1-1 libsvn1 subversion

#install go lang
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install golang-go

# install WP-CLI
sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# install Composer
sudo curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# install Node.js
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install nodejs
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install nodejs-legacy
# install npm
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install npm
sudo npm update npm -g

# install grunt
npm install -g grunt-cli
# install bower
npm install -g bower
# install gulp
npm install -g gulp

