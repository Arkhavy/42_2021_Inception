FROM debian:buster

ARG DB_NAME
ARG DB_USER
ARG DB_USER_PW
ARG DB_ROOT_PW

# Server Package update and installation of needed softwares
	# dumb-init is a process supervisor that runs as PID 1 to avoid signal handling problems
RUN apt update -y && apt upgrade -y
RUN apt install -y mariadb-server dumb-init

# MySQL Service start & configuration
	# ALTER USER allows to change the authentication of a DB user
	# GRANT is used to give all tables permissions
	# FLUSH PRIVILEGES is used to update the changes done
RUN service mysql start \
&& mysql -u root -e	"CREATE DATABASE IF NOT EXISTS ${DB_NAME}; \
						ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PW}'; \
						CREATE USER ${DB_USER}@'%' IDENTIFIED BY '${DB_USER_PW}'; \
						GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%'; \
						FLUSH PRIVILEGES;"

# Informs Docker that the container listens to that port at runtime with TCP by default
EXPOSE 3306

# Start of the container
# mysqld is the MySQL server daemon process that runs in the background and handles client connections.
# --bind-address=0.0.0.0 sets the IP address, 0.0.0.0 means the server will listen on all available network interfaces.
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["mysqld", "--bind-address=0.0.0.0"]