#!/usr/bin/env bash

# MongoDb
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
apt-get update

echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list

# Redis
# alternative to test
# https://www.digitalocean.com/community/tutorials/how-to-configure-a-redis-cluster-on-ubuntu-14-04
echo "deb http://packages.dotdeb.org squeeze all" |  tee /etc/apt/sources.list.d/dotdeb.org.list
echo "deb-src http://packages.dotdeb.org squeeze all" |  tee /etc/apt/sources.list.d/dotdeb.org.list

wget -q -O - http://www.dotdeb.org/dotdeb.gpg | apt-key add -

apt-get update -y

debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

# nginx git mongodb php mysql node npm
apt-get install -y --force-yes  nginx git mongodb-org redis-server build-essential openssl libssl-dev pkg-config php5-fpm php5-gd php5-common php5-curl php5-mcrypt php5-memcache php5-mysql php5-intl php5-cli php5-mongo php5-redis php-apc mysql-server mysql-client-core-5.5 mysql-client-5.5

# bonus
# nodejs npm

# install gulp
#npm install -g gulp

# Start mongod
service mongod start

# Add mcrypt
php5enmod mcrypt
/etc/init.d/php5-fpm restart

# create mysql DB
mysql -uroot -proot -e "create database tapioca_dev"

# global PHPunit install
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
mv phpunit.phar /usr/bin/phpunit

php -r "readfile('https://getcomposer.org/installer');" | php
mv composer.phar /usr/bin/composer

# laravel bins
composer global require "laravel/installer=~1.1"

# Add laravel Composer Bin to global path
echo 'export PATH="$PATH:~/.composer/vendor/bin"' >> ~/.bashrc
source ~/.bashrc

# bootstrap app
cd /var/www/tapioca.dev/
composer install -n
