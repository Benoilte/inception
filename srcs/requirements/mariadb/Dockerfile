FROM debian:bookworm

RUN apt update -y && apt install -y mariadb-server

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/setup.sh	setup.sh

RUN chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]
