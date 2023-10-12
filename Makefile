# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ljohnson <ljohnson@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/09/05 11:16:03 by ljohnson          #+#    #+#              #
#    Updated: 2023/09/27 16:52:49 by ljohnson         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

.PHONY: all up down start restart stop clean fclean prune re
# .SILENT:

NAME	:= inception

#//////////////////////////////////////////////////////////////////////////////
#		ALL FILES
#//////////////////////////////////////////////////////////////////////////////

# Directories
P_SRCS			:=	srcs/

# Shortcuts
P_REQ			:=	$(addprefix $(P_SRCS),requirements/)

P_NGINX			:=	$(addprefix $(P_REQ),nginx/)
P_MARIADB		:=	$(addprefix $(P_REQ),mariadb/)
P_WORDPRESS		:=	$(addprefix $(P_REQ),wordpress/)

#//////////////////////////////////////////////////////////////////////////////
#		FLAGS & TEXT MODIFIERS
#//////////////////////////////////////////////////////////////////////////////

# Commands & Flags
COMPOSE	:= docker compose -f $(P_SRCS)docker-compose.yml -p $(NAME)
RM		:=	rm -rf
MKDIR	:= mkdir -p

#//////////////////////////////////////////////////////////////////////////////
#		RULES
#//////////////////////////////////////////////////////////////////////////////

all: up

# Create and start containers
up:
	$(MAKE) volumes
	$(COMPOSE) up -d --build

volumes:
	$(MKDIR) /home/$(USER)/data/wordpress
	$(MKDIR) /home/$(USER)/data/mariadb

# Stops and remove containers, networks, volumes, and images created by up
down:
	$(COMPOSE) down --rmi all -v --remove-orphans

# Mandatory rules
clean:
	$(MAKE) down

fclean:
	$(MAKE) clean
	$(RM) /home/$(USER)/data/wordpress/*
	$(RM) /home/$(USER)/data/mariadb/*

prune:
	$(MAKE) fclean
	docker system prune -f -a --volumes

re :
	$(MAKE) fclean
	$(MAKE) all
