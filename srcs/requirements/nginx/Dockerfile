FROM debian:bookworm

RUN apt update && apt upgrade
RUN apt install nginx vim curl -y

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/setup.sh /setup.sh

RUN chmod +x setup.sh && ./setup.sh

CMD [ "nginx", "-g", "daemon off;" ]
