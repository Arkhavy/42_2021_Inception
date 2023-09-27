FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y dumb-init php-fpm php-mysqli curl

ADD		https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN		chmod +x /usr/local/bin/wp

RUN mkdir -p /var/www/html/wordpress

EXPOSE 9000

COPY /tools/entrypoint.sh /tmp

COPY /conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/tmp/entrypoint.sh"]
