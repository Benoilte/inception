#!/bin/bash
set -e

# Ensure required env vars are set
if [ -z "$INCEPTION_MYSQL_DATABASE" ] || [ -z "$INCEPTION_MYSQL_USER" ] || [ -z "$INCEPTION_MYSQL_PASS" ] || [ -z "$INCEPTION_MYSQL_ROOT_PASS" ]; then
    echo "ERROR: One or more required environment variables are missing."
    exit 1
fi

# Ensure socket directory exists
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

echo "Starting MariaDB in background..."
mysqld_safe --datadir=/var/lib/mysql &

MAX_RETRIES=30
COUNT=0

until mysqladmin ping --silent; do
    COUNT=$((COUNT+1))
    if [ $COUNT -ge $MAX_RETRIES ]; then
        echo "ERROR: MariaDB did not start within $((MAX_RETRIES*2)) seconds."
        exit 1
    fi
    sleep 2
done

echo "MariaDB is up — configuring database..."

# Secure root and create database + user
mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${INCEPTION_MYSQL_ROOT_PASS}';
CREATE DATABASE IF NOT EXISTS \`${INCEPTION_MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${INCEPTION_MYSQL_USER}'@'%' IDENTIFIED BY '${INCEPTION_MYSQL_PASS}';
GRANT ALL PRIVILEGES ON \`${INCEPTION_MYSQL_DATABASE}\`.* TO '${INCEPTION_MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Stop background mysqld
mysqladmin -uroot -p"${INCEPTION_MYSQL_ROOT_PASS}" shutdown

# Relaunch MariaDB in foreground for Docker
exec mysqld_safe --datadir=/var/lib/mysql
