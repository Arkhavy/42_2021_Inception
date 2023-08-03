P_SRCS			:=	srcs/
P_REQ			:=	$(addprefix $(P_SRCS),requirements/)

P_NGINX			:=	$(addprefix $(P_REQ),nginx/)
# P_MARIADB		:=	$(addprefix $(P_REQ),mariadb/)
# P_WORDPRESS		:=	$(addprefix $(P_REQ),wordpress/)

all: build_nginx # build_maria_db build_wordpress

build_nginx:
	sudo docker build -t nginx $(P_NGINX)

# build_maria_db:
# 	docker build -t mariadb $(P_MARIADB)

# build_wordpress:
# 	docker build -t wordpress $(P_WORDPRESS)

# doesn't work since $() is a Makefile variable in itself. Need to bypass that somehow
# clean:
# 	sudo docker container rm -f $(sudo docker container ls -aq)
# 	sudo docker image rm -f $(sudo docker image ls -aq)