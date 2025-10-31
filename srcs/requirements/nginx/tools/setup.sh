mkdir -p /etc/nginx/ssl

apt install openssl -y

openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=bebrandt.42.fr/UID="

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/inception.key \
  -out /etc/nginx/ssl/inception.crt \
  -subj "/CN=bebrandt.42.fr"

mkdir -p /var/run/nginx

chmod 755 /var/www/html

chown -R www-data:www-data /var/www/html
