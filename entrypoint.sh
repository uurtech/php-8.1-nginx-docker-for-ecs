#!/bin/bash

/etc/init.d/php7.4-fpm restart

[ ! -f "/var/www/html/wp-config.php" ] && cd /tmp && wget https://wordpress.org/latest.tar.gz && tar -xvzf latest.tar.gz && mv wordpress/* /var/www/html

mkdir /var/www/html/wp-content/temp
chown -R www-data:www-data /var/www/ &
echo "running chown"

printenv
nginx -g 'daemon off;'