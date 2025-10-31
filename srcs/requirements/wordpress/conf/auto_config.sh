#!/bin/bash

sleep 10

WP_PATH="/var/www/html"

chown -R www-data:www-data $WP_PATH

if [ ! -f "$WP_PATH/wp-config.php" ]; then

	cd $WP_PATH

	wp core download --allow-root

	wp config create \
		--dbname=${INCEPTION_MYSQL_DATABASE} \
		--dbuser=${INCEPTION_MYSQL_USER} \
		--dbpass=${INCEPTION_MYSQL_PASS} \
		--dbhost=mariadb:3306 --allow-root

	wp core install \
		--url=${INCEPTION_DOMAIN_NAME} \
		--title=${INCEPTION_WP_TITLE} \
		--admin_user=${INCEPTION_WP_A_NAME} \
		--admin_password=${INCEPTION_WP_A_PASS} \
		--admin_email=${INCEPTION_WP_A_EMAIL} \
		--skip-email \
		--allow-root

	wp user create ${INCEPTION_WP_U_NAME} ${INCEPTION_WP_U_EMAIL} \
		--user_pass=${INCEPTION_WP_U_PASS} \
		--role=${INCEPTION_WP_U_ROLE} --allow-root

	mkdir -p /run/php
fi

/usr/sbin/php-fpm8.2 -F
