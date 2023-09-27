# Download Wordpress core files
wp core download	--path="/var/www/html/wordpress" \
					--allow-root

# Create and configure the wp-config.php file
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php \
&&		sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wordpress/wp-config.php \
&&		sed -i "s/username_here/$DB_USER/" /var/www/html/wordpress/wp-config.php \
&&		sed -i "s/password_here/$DB_USER_PW/" /var/www/html/wordpress/wp-config.php \
&&		sed -i "s/localhost/$DB_HOST/" /var/www/html/wordpress/wp-config.php

# wp config create	--path="/var/www/html/wordpress" \
# 					--allow-root \
# 					--dbname=$DB_NAME \
# 					--dbuser=$DB_USER \
# 					--dbpass=$DB_USER_PW \
# 					--dbhost=$DB_HOST \
# 					--dbprefix=wp_

# Standard wordpress installation
wp core install		--path="/var/www/html/wordpress" \
					--allow-root \
					--url=$DOMAIN_NAME \
					--title="$WP_TITLE" \
					--admin_user=$WP_ADMIN \
					--admin_password=$WP_ADMIN_PW \
					--admin_email=$WP_ADMIN_MAIL

# Updates all wordpress plugins, just to be sure everything is up to their latest version
wp plugin update	--allow-root \
					--all

# Create a new user with its password
wp user create		--path="/var/www/html/wordpress" \
					--allow-root $WP_USER $WP_USER_MAIL \
					--user_pass=$WP_USER_PW

# Give permissions to group and user www-data to uploads, command executed as root with -R
chown www-data:www-data /var/www/html/wordpress/wp-content/uploads -R

# php-fpm start
mkdir -p /run/php/
php-fpm7.3 -F
