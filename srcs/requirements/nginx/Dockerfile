FROM debian:buster
RUN apt update -y && apt upgrade -y
RUN apt install -y nginx vim curl openssl

WORKDIR /home/
COPY conf/ .
RUN rm -rf /etc/nginx/sites-enabled/default && mv /home/nginx.conf /etc/nginx/sites-enabled/default

RUN openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/C=FR/ST=Auvergne-Rhone-Alpes/L=Lyon/UID=ljohnson/emailAddress=ljohnson@student.42lyon.fr"

ENTRYPOINT ["nginx", "-g", "daemon off;"]