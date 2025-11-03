FROM debian:bookworm

RUN apt-get update -y && apt-get install -y  wget
RUN apt-get update -y && apt-get install -y  php7.3\
											 php-fpm\
											 php-mysql\
											 mariadb-client

COPY /tools/setup.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh

COPY /conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY /conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

ENTRYPOINT [ "/usr/local/bin/auto_config.sh" ]
