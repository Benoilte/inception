FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/setup.sh /setup.sh

RUN chmod +x setup.sh && ./setup.sh

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
