#!/usr/bin/env bash

# create /public/ dir
sudo mkdir "/var/www/$2/public_html"

# update / upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# install bzip2
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install bzip2

#install vim
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install vim

# install apache 2.5 and php 5.5
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install apache2
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install php5 libapache2-mod-php5 php5-mcrypt php5-xdebug php5-gd 
#install curl
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install curl libcurl3 libcurl3-dev php5-curl

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $3"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $3"
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install php5-mysql

#start mysql
sudo service mysql start

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $3"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $3"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $3"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install phpmyadmin

# setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/$2/public_html"
    <Directory "/var/www/$2/public_html">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# enable mod_rewrite
sudo a2enmod rewrite

# install git
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install git
# install svn
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install libserf-1-1 libsvn1 subversion

#install WP-CLI
sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# install Composer
sudo curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# install Node.js 
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install nodejs
# install npm
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install npm

#install grunt
npm install -g grunt-cli
#install bower
npm install -g bower
#install gulp
npm install -g gulp

#install yeoman
#npm install -g yo
#install yeoman webapp generator
#npm install -g generator-webapp
#install yeoman angular generator
#npm install -g generator-angular

# create index.php
sudo chmod 755 /var/www
sudo printf  "<h1>Welcome!</h1> <br> <a href='/phpmyadmin/'>PHPMyAdmin</a>  <hr> <?php phpinfo();?>" > "/var/www/$2/public_html/index.php"

# restart apache
service apache2 restart