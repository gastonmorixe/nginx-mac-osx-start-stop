#! /bin/bash
NGINX="/usr/local/sbin/nginx"
NGINXPIDPATH="/usr/local/etc/nginx"
NGINXCONFIG="/usr/local/etc/nginx/nginx.conf"

PHPFPM="/usr/local/sbin/php-fpm"
PHPFPMPIDPATH="/usr/local/Cellar/php/5.3.6/var/run"

#MEMCACHED="/opt/local/bin/memcached -m 24 -P /opt/local/var/run/memcached.pid -u root"

if [ $1 = "start" ]; then
	echo "Starting php-fpm ..."
	sudo $PHPFPM
	echo "Starting nginx ..."
	sudo $NGINX -c $NGINXCONFIG
	echo "Done!"
elif [ $1 = "stop" ]; then
	echo "Stopping nginx ..."
	sudo kill `cat $NGINXPIDPATH/nginx.pid`
	echo "Stopping php-fpm ..."
	sudo kill `cat $PHPFPMPIDPATH/php-fpm.pid`
	echo "Done!"
elif [ $1 = "restart" ]; then
	echo "Stopping nginx ..."
	sudo kill `cat $NGINXPIDPATH/nginx.pid`
	echo "Stopping php-fpm ..."
	sudo kill `cat $PHPFPMPIDPATH/php-fpm.pid`
	echo "Starting php-fpm ..."
	sudo $PHPFPM
	echo "Starting nginx ..."
	sudo $NGINX -c $NGINXCONFIG
	echo "Done!"
elif [ $1 = "nginx" ]; then
	if [ $2 = "start" ]; then
		echo "Starting nginx ..."
		sudo $NGINX -c $NGINXCONFIG
	elif [ $2 = "stop" ]; then
		echo "Stopping nginx ..."
		sudo kill `cat $NGINXPIDPATH/nginx.pid`
	elif [ $2 = "restart" ]; then
		echo "Stopping nginx ..."
		sudo kill `cat $NGINXPIDPATH/nginx.pid`
		echo "Starting nginx ..."
		sudo $NGINX -c $NGINXCONFIG
	else
		echo "Valid commands for nginx: start | stop | restart"
	fi
elif [ $1 = "php" ] || [ $1 = "php-fpm" ]; then
	if [ $2 = "start" ]; then
		echo "Starting php-fpm ..."
		sudo $PHPFPM
	elif [ $2 = "stop" ]; then
		echo "Stopping php-fpm ..."
		sudo kill `cat $PHPFPMPIDPATH/php-fpm.pid`
	elif [ $2 = "restart" ]; then
		echo "Stopping php-fpm ..."
		sudo kill `cat $PHPFPMPIDPATH/php-fpm.pid`
		echo "Starting php-fpm ..."
		sudo $PHPFPM
	else
		echo "Valid commands for php-fpm: start | stop | restart"
	fi
else
	echo "Valid commands: "
	echo "start | stop | restart"
	echo "----------------------------------------"
	echo "nginx (start | stop | restart)"
	echo "php | php-fpm (start | stop | restart)"
fi