FROM debian:buster

# Server Package update and installation of needed softwares
	# dumb-init is a process supervisor that runs as PID 1 to avoid signal handling problems
RUN apt update -y && apt upgrade -y
RUN apt install -y nginx openssl dumb-init

# NGINX configuration file
	# Doing a symbolic link from sites-available to sites-enabled like default file
COPY /conf/nginx.conf /etc/nginx/sites-available/ljohnson.42.fr.conf
RUN ln -s /etc/nginx/sites-available/ljohnson.42.fr.conf /etc/nginx/sites-enabled/ljohnson.42.fr.conf

# OpenSSL self-signed certificate & key
	# -nodes is "no Data Encryption Standard", avoid encryption of the private key to avoid passphrase prompt
	# req -x509 for the creation of a self-signed certificate
	# -newkey rsa:2048 for the generation of a key
	# -keyout for the output of the key generated
	# -out for the output of the certificate generated
RUN openssl req -x509 -nodes -newkey rsa:2048 \
	-keyout /etc/ssl/private/ljohnson.42.fr.key \
	-out /etc/ssl/certs/ljohnson.42.fr.crt \
	-subj "/C=FR/ST=Auvergne-Rhone-Alpes/L=Lyon/UID=ljohnson/emailAddress=ljohnson@student.42lyon.fr"

# Informs Docker that the container listens to that port at runtime with TCP by default
EXPOSE 443

# Start of the container
	# daemon off directive to avoid nginx running in background
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["nginx", "-g", "daemon off;"]