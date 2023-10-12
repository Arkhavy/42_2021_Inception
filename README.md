# Inception : all important parts of the project from my point of view

# Makefile

## [docker-compose](https://docs.docker.com/engine/reference/commandline/compose/)

### [Command Line Interface (CLI) overview](https://docs.docker.com/compose/reference/)

##### flags used
- `-f "file"` : specify which docker-compose file we're using

####	[docker-compose up](https://docs.docker.com/engine/reference/commandline/compose_up/)

##### flags used
- `-d` : detach mode, run containers in background
- `--build` : build images before starting containers

####	[docker-compose-down](https://docs.docker.com/engine/reference/commandline/compose_down/)

##### flags used
- `--rmi all` : remove images used by services
- `-v` : same as --volumes, removes named volumes declared in the docker-compose file and thoses attached to containers
- `--remove-orphans` : Remove containers for services not defined in the docker-compose file

#	[docker system](https://docs.docker.com/engine/reference/commandline/system/)

####	[docker system prune](https://docs.docker.com/engine/reference/commandline/system_prune/)

##### flags used
- `-f` : same as --force, do not prompt for confirmation
- `-a` : same as --all, remove all unused images, containers, networks
- `--volumes` : remove volumes too

_____
# docker-compose.yml

[Compose file format version](https://docs.docker.com/compose/compose-file/compose-versioning/)
[Compose file definition](https://docs.docker.com/compose/compose-file/03-compose-file/)
All links from the list below are from this page : [Compose file version 3 reference](https://docs.docker.com/compose/compose-file/compose-file-v3/)

- `version: "x.x"` : Compose File format version compatible with Docker Engine release version
<br>

###### [top-level `services:`](https://docs.docker.com/compose/compose-file/compose-file-v3/#service-configuration-reference) : Defines all the different containers. Each service represents a container.

- [`container_name`](https://docs.docker.com/compose/compose-file/compose-file-v3/#container_name) : Specifies a custom name for the container.
- [`build`](https://docs.docker.com/compose/compose-file/compose-file-v3/#build) : Configuration options that are applied at build time.
- [`args`](https://docs.docker.com/compose/compose-file/compose-file-v3/#args) : Add build arguments which are environment variables accessible only during the build process.
- [`context`](https://docs.docker.com/compose/compose-file/compose-file-v3/#context) : Specifies the relative directory path where is located the Dockerfile of the service.
- [`image`](https://docs.docker.com/compose/compose-file/compose-file-v3/#image) : Specify the image to start the container from. If build is also specified, it serves the purpose of a tag.
- [`env_file`](https://docs.docker.com/compose/compose-file/compose-file-v3/#env_file) : Add environment variables from a file. can be a single value or a list.
- [`environment`](https://docs.docker.com/compose/compose-file/compose-file-v3/#environment) : Allows setting up an environment variable in the container. Overrides env_file values if variables have the same name.
- [`depends_on`](https://docs.docker.com/compose/compose-file/compose-file-v3/#depends_on) : Specifies that a service depends on another service. `docker-compose up` starts services in dependency order.
- [`ports`](https://docs.docker.com/compose/compose-file/compose-file-v3/#ports) : Used to map the container's port to the host machine.
- [`init`](https://docs.docker.com/compose/compose-file/compose-file-v3/#init) : Runs an init inside the container that forwards signals and reaps processes.
- [`restart`](https://docs.docker.com/compose/compose-file/compose-file-v3/#restart) : restart policy, `no` is default.
- [`volumes:`](https://docs.docker.com/compose/compose-file/compose-file-v3/#volumes) : Used by pair with **top-level volumes** part, defines mount paths within a named volume.
- [`networks`](https://docs.docker.com/compose/compose-file/compose-file-v3/#networks) : Used by pair with **top-level networks** parts, specifies the networks services should be connected to.
<br>

###### [top-level `volumes`](https://docs.docker.com/compose/compose-file/compose-file-v3/#volume-configuration-reference) : Defines all the different named volumes that can be reused across multiple services.

- [`name`](https://docs.docker.com/compose/compose-file/compose-file-v3/#name) : Set a custom name for this volume.
- [`driver`](https://docs.docker.com/compose/compose-file/compose-file-v3/#driver) : Specify which volume driver should be used.
- [`driver_opts`](https://docs.docker.com/compose/compose-file/compose-file-v3/#driver_opts) : Specifies a list of options as key-value pairs to pass to the driver for this volume. Driver-dependent.
- `driver : local` is the [standard linux mount](https://man7.org/linux/man-pages/man8/mount.8.html) options.
- `type` : Specifies the type of volume driver to use. `none` indicates the service does not require any persistent storage.
- `o` : Specifies the mount options for the volume. `bind` is a way to mount a directory from the host machine into the container.
- `device` : Specifies the path on the host machine that is mounted into the container.
<br>

###### [top-level `networks`](https://docs.docker.com/compose/compose-file/compose-file-v3/#network-configuration-reference) : Defines networks to be created.

- [`name`](https://docs.docker.com/compose/compose-file/compose-file-v3/#name-1) : Set a custom name for this network.
- [`driver`](https://docs.docker.com/compose/compose-file/compose-file-v3/#driver-1) : Specify which driver should be used for this network. [Bridge](https://github.com/docker/labs/blob/master/networking/A2-bridge-networking.md) is default.
- [`driver_opts`](https://docs.docker.com/compose/compose-file/compose-file-v3/#driver_opts-1) : Specifies a list of options as key-value pairs to pass to the driver for this network. Driver-dependent.

_____
# Environment file with Docker Compose

[Use an environment file in Docker Compose](https://docs.docker.com/compose/environment-variables/env-file/)

- The environment file must contain the same syntax for each variables : `VAR=VAL`, `VAR="VAL"` or `VAR='VAL'` are accepted.
- **Comments**, **inline comments** and **blank lines** are ignored.
- Environment variables handled by docker-compose have the same behavior as any shell variables.
- It includes **parameter expansion**, **quotes** and **double-quotes** handling, **escape characters**, **direct substitution** and [**precedence**](https://docs.docker.com/compose/environment-variables/envvars-precedence/).
- Since we can use **multiple environment files**, be careful about the order you put them in your **docker-compose file**, because the last value of a variable that is declared multiple times will be taken into consideration.
- The list of environment file is read with a **top-down order by docker-compose**.

_____
# Writing a Dockerfile

[Dockerfile reference](https://docs.docker.com/engine/reference/builder/)

- `FROM` : Sets the base image for subsequent instructions.
- `COPY` : Copies new files or directories and adds them to the filesystem of the container at the path designed
- `ADD` : Same as COPY but with TAR files extraction and URL handling.
- `RUN` : Run any comand given in a new layer on top of the current image and commit the results. The commited image will be used for the next step in the Dockerfile.
- `ENTRYPOINT` : Allows to configure a container that will run as an executable.
- `CMD` : Provides defaults for an executing container. Can include an executable, if not, `ENTRYPOINT`` must be precised.
- `ARG` : Defines a variable that users can pass at build-time.
- `EXPOSE` : Informs Docker that the container listens on the specified network ports at runtime. Purely informational, does not actually publish the port.
- `ENV` : Sets the environment variable key-value pair. This value will be in the environment for all subsequent instructions in the build stage.
- `WORKDIR` : Sets the working directory for any `RUN`, `CMD`, `ENTRYPOINT`, `COPY` and `ADD` instructions that follows this instruction.

_____
# NGINX Part

- [Ubuntu NGINX Installation tutorial](https://ubuntu.com/tutorials/install-and-configure-nginx)
- [dumb-init](https://github.com/Yelp/dumb-init) : PID 1 handling.
- [openssl](https://www.digicert.com/kb/csr-ssl-installation/nginx-openssl.htm) : Key and Certificate creation.
- [fastCGI](https://nginx.org/en/docs/http/ngx_http_fastcgi_module.html) : Communication between NGINX and application server (wordpress / php-fpm).

_____
# MariaDB / mysql Part

- [Account Management Statements](https://dev.mysql.com/doc/refman/8.0/en/account-management-statements.html)
<br>

- `CREATE DATABASE <database_name>;` : [Create a database.](https://dev.mysql.com/doc/refman/8.0/en/create-database.html)
- `DROP DATABASE <database_name>;` : [Delete a database.](https://dev.mysql.com/doc/refman/8.0/en/drop-database.html)
- `CREATE USER '<username>'@'<host>';` : [Create a user.](https://dev.mysql.com/doc/refman/8.0/en/create-user.html)
- `CREATE USER '<username>'@'<host>' IDENTIFIED BY '<password>';` : Create a user and set user's password.
- `ALTER USER '<username>'@'<host>' IDENTIFIED BY '<new_password>';` : [Change a user's password.](https://dev.mysql.com/doc/refman/8.0/en/alter-user.html)
- `DROP USER '<username>'@'<host>';` : [Delete a user.](https://dev.mysql.com/doc/refman/8.0/en/drop-user.html)
- `GRANT <privileges> ON <database_name> TO '<username>'@'<host>';` : [Give privileges](https://dev.mysql.com/doc/refman/8.0/en/grant.html) to a user on a database.
- `REVOKE <privileges> ON <database_name> FROM '<username>'@'<host>';` : [Remove privileges](https://dev.mysql.com/doc/refman/8.0/en/revoke.html) from a user on a database.
- `FLUSH PRIVILEGES;` : [Reload all privilege changes to update them.](https://dev.mysql.com/doc/refman/8.0/en/flush.html) *personal note : should not be needed with grant and revoke, used as security.*

_____
# Wordpress / php-fpm Part

- [wp-cli : Wordpress Command Line Interface](https://github.com/wp-cli/wp-cli)
- [wp-cli : wp-cli complete list of commands](https://developer.wordpress.org/cli/commands/)
- [PHP-FPM](https://www.php.net/manual/en/install.fpm.php), or `PHP FastCGI Process Manager` is an implementation commonly used with web servers like nginx to handle php requests.
<br>

- `www.conf` file : php-fpm configuration file, here just to change the line from `listen = /run/php/php7.3-fpm.sock` to `listen = wordpress:9000`
- `listen` directive : specifies the address on which php-fpm will accept FastCGI requests.
<br>

- [`wp core download`](https://developer.wordpress.org/cli/commands/core/download/) : Downloads the Wordpress core files.
- [`wp config create`](https://developer.wordpress.org/cli/commands/config/create/) : Creates a new wp-config.php file with the necessary db constants and verifies that the db constants are correct.
- [`wp core install`](https://developer.wordpress.org/cli/commands/core/install/) : Installs Wordpress with the provided configuration.
- [`wp plugin update`](https://developer.wordpress.org/cli/commands/plugin/update/) : Updates a Wordpress plugin to the latest version.
- [`wp user create`](https://developer.wordpress.org/cli/commands/user/create/) : Creates a new Wordpress user.
<br>

- `--allow-root` flag : Allows wp-cli commands to be executed as the root user, bypassing the check for the current user's permissions.
- `--path` flag : Allows to explicitly specify the path to the Wordpress installation directory. By default, wp-cli assumes that the current working directory is the root directory of the Wordpress installation.
<br>

- `php-fpm7.3 -F` : Used to start the php-fpm service and keep it running in the foreground.

*Personal notes : got some problems with wp-cli 2.8 that prevented me from doing the installation with some of the commands listed above, an older version might fix a lot of things depending on the problem you face.*

_____
# VM Configuration / Checking things in the project

*Personal notes : The following checks are the minimum for a working project. Some checks might be missing or be incomplete, feel free to do your own as well, if you feel like helping, you can contact me so I can add those here !*

- adding the line `127.0.0.1	login.42.fr` in the file `/etc/hosts` so localhost is assigned to the given domain name
<br>

**Some Docker commands** :
- `docker exec -it <container_tag> bash` : access the named container using bash.
- `docker ps` : Display containers currently running.
- `docker volume ls` : Display a list of volumes currently available.
- `docker volume inspect <volume_name>` : display details about a specific volume, the mounted directory should be `login/data/volume_name` for both mandatory volumes.
<br>

**In MariaDB container** :
- `mysql -u <username> -p` : Will connect you to the database and prompt you with the user password, you can use the root one as well as the db_user one, both must have a password.
- `SHOW DATABASE;` : will list all available databases, should be two, the default one and yours that should be named by your dockerfile commands.
- `USE <db_name>;` : Gives you access to the named database, Terminal prompt should look like `MariaDB [db_name]`.
- `SHOW TABLES;` : Display a list of tables currently available in the current db.
- `SELECT * FROM <table_name>;` : Should display the whole content defined by `*` of the selected table from the list given by `SHOW TABLES;`, `wp_users` should as example display admin and users currently registered to wordpress linked to the database.
<br>

**Some tests you can do with wordpress** :
- login as a registered user through `https://login.42.fr/wp-admin`.
- Add a comment to a page with that user.
- login as admin through `https://login.42.fr/wp_admin`.
- Approve the comment.
- Go to the `page` section on the left and edit any existing page.
- reboot VM or Docker itself.
- Changes should still be visible if the database is not updated.

_____
# Phind questions and answers

*Phind is a GPT based AI search engine. Answers given here might lack some informations / might be inaccurate.*
*The following answers are pasted here without any modification for documentation purpose.*
*I would suggest to verify by yourself each sources given at the end of this document and make your own research as well.*

### What is the difference between ADD and COPY instructions in a Dockerfile ?

The Dockerfile instructions `ADD` and `COPY` are used to copy files and directories into a Docker image. While they have similar goals, there are a few differences between them. Here's an overview:

1. **COPY**: The `COPY` instruction copies files or directories from the host machine to the destination path in the image. It takes two arguments: the source and the destination. The source can be a file or a directory, and the destination is the path within the image where the file or directory will be copied. For example:
   ```
   COPY app.jar /usr/src/app/
   ```

2. **ADD**: The `ADD` instruction also copies files or directories from the host machine to the destination path in the image. In addition to what `COPY` does, `ADD` has two additional features:
   - It can automatically extract TAR files and URLs. For example, if the source is a TAR file, it will be automatically extracted in the image. However, it's important to note that `ADD` should not be used to extract arbitrary URLs, as it can lead to unexpected files being written to the image.
   - It allows remote URLs as the source. For example:
     ```
     ADD https://example.com/app.tar.gz /usr/src/app/
     ```

   The use of remote URLs is a unique feature of `ADD`, and it can be useful for downloading and incorporating external resources into the image.

The general recommendation is to use `COPY` over `ADD` unless one of the additional features of `ADD` is specifically needed. The Docker best practices guide advises using `COPY` to avoid potential confusion and to have more control over what is being copied into the image [1][2]. Using `COPY` is considered a best practice because it provides a clear and explicit way to copy files and directories, without any unexpected behavior or additional layers in the image [1].

It's worth noting that both `COPY` and `ADD` instructions create new layers in the Docker image. Minimizing the number of layers in the image is recommended for better performance and smaller image size [4].

### What do I have to know to make a good docker-compose.yml file ?

To create a good `docker-compose.yml` file, there are a few key things you need to know:

1. Understand the basics of Docker Compose: Docker Compose is a tool used to define and manage multi-container applications. It allows you to define the services, networks, and volumes required for your application in a YAML file. With Docker Compose, you can launch and manage multiple containers with a single command[5].

2. Familiarize yourself with the syntax and structure of a `docker-compose.yml` file: A `docker-compose.yml` file consists of version, services, networks, and volumes sections. Here's a basic example:

   ```yaml
   version: '3'
   services:
     service1:
       image: image1
     service2:
       image: image2
   networks:
     network1:
     network2:
   volumes:
     volume1:
     volume2:
   ```

   - The `version` specifies the version of the Docker Compose syntax being used.
   - The `services` section defines the containers that make up your application.
   - The `networks` section defines the networks your containers will be connected to.
   - The `volumes` section defines the volumes that will be mounted to your containers[6].

3. Specify the services: In the `services` section of your `docker-compose.yml` file, you define the containers that make up your application. For each service, you need to specify the image, ports, volumes, environment variables, and any other configuration specific to that service. Here's an example:

   ```yaml
   services:
     service1:
       image: image1
       ports:
         - "8080:80"
       volumes:
         - ./data:/data
       environment:
         - ENV_VAR=value
     service2:
       image: image2
       ...
   ```

   In this example, `service1` is defined with an image, port mapping, volume mapping, and an environment variable. Adjust these settings based on the requirements of your application[6].

4. Define networks and volumes: In addition to services, you may need to define networks and volumes in your `docker-compose.yml` file. Networks allow containers to communicate with each other, and volumes provide persistent storage for your containers. Here's an example:

   ```yaml
   networks:
     network1:
     network2:

   volumes:
     volume1:
     volume2:
   ```

   You can then specify the networks and volumes in the services section as needed[6].

5. Consider best practices: To create a well-structured and maintainable `docker-compose.yml` file, consider the following best practices:

   - Use version control: Store your `docker-compose.yml` file in version control to track changes and collaborate with others.
   - Use environment variables: Use environment variables to make your `docker-compose.yml` file configurable and reusable across different environments.
   - Use named volumes: Instead of relying on host-mounted volumes, use named volumes to provide a more portable and scalable solution.
   - Use aliases and links: Use container aliases and links to establish communication between containers.
   - Use container health checks: Include health checks in your `docker-compose.yml` file to ensure the availability and reliability of your services[7].

Remember, these are just general guidelines, and the specific requirements of your application may vary. It's always a good idea to refer to the official Docker documentation and other reliable sources for more detailed information and examples[5][7].

### Can you explain like I'm 5 how fastcgi works with nginx ?

FastCGI is a protocol used by Nginx to communicate with application servers that process dynamic content. To explain it like you're 5:

1. Nginx is like a waiter at a restaurant. It takes requests from customers (web browsers) and serves them the food (web pages) they ordered.
2. Sometimes, the food needs to be cooked by a chef (application server) before it can be served. FastCGI is like a special language that the waiter and chef use to talk to each other and coordinate the cooking process.
3. The waiter (Nginx) sends the order to the chef (application server) using the FastCGI protocol. The chef then prepares the food (processes the request) and sends it back to the waiter.
4. The waiter (Nginx) serves the cooked food (response) to the customer (web browser), who can then enjoy the delicious web page.

Here are some key points about how FastCGI works with Nginx, based on the search results:

- Nginx can use FastCGI to proxy requests to application servers that process dynamic content[8].
- FastCGI is a protocol that allows Nginx to communicate with the application server efficiently and handle dynamic content requests[8].
- FastCGI is commonly used for PHP processing with Nginx, where Nginx acts as a proxy to a separate PHP processor like php-fpm[8].
- FastCGI configurations in Nginx can be declared at a general scope to avoid repetition and improve maintainability[8].
- Nginx provides directives, parameters, and variables to configure FastCGI settings, such as the FastCGI backend, script filenames, and query strings[8].
- To configure Nginx to proxy requests to a FastCGI server, you can use the `fastcgi_pass` directive and set the appropriate parameters, such as the script filename and query string[9][10].

Here's an example configuration for Nginx to work with a FastCGI server, such as PHP-FPM[10]:

```
server {
    location / {
        fastcgi_pass  localhost:9000;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param QUERY_STRING    $query_string;
    }
    location ~ \.(gif|jpg|png)$ {
        root /data/images;
    }
}
```

In this configuration, Nginx will route all requests (except for static images) to the FastCGI server operating on `localhost:9000` using the FastCGI protocol. The `SCRIPT_FILENAME` parameter is used to determine the script name, and the `QUERY_STRING` parameter is used to pass request parameters[10].

Overall, FastCGI allows Nginx to efficiently handle dynamic content requests by communicating with application servers using a specialized protocol, ensuring fast and reliable delivery of web pages to users.

*Phind Sources*:
- [Source 1 : baeldung.com : Docker copy & add difference](https://www.baeldung.com/ops/docker-copy-add)
- [Source 2 : linuxhandbook.com : Docker copy & add difference](https://linuxhandbook.com/dockerfile-copy-add-difference/)
- [Source 3 : pluralsight.com : Docker copy & add difference](https://www.pluralsight.com/resources/blog/cloud/docker-copy-vs-add-whats-the-difference)
- [Source 4 : docs.docker.com : Dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Source 5 : howtogeek.com : What is docker-compose](https://www.howtogeek.com/devops/what-is-docker-compose-and-how-do-you-use-it/)
- [Source 6 : medium.com : Docker-compose and Makefile](https://medium.com/freestoneinfotech/simplifying-docker-compose-operations-using-makefile-26d451456d63)
- [Source 7 : docs.docker.com : Get started using Compose](https://docs.docker.com/get-started/08_using_compose/)
- [Source 8 : digitalocean.com : Understanding FastCGI](https://www.digitalocean.com/community/tutorials/understanding-and-implementing-fastcgi-proxying-in-nginx)
- [Source 9 : nginx.org : FastCGI module](https://nginx.org/en/docs/http/ngx_http_fastcgi_module.html)
- [Source 10 : nginx.org : Beginners guide](https://nginx.org/en/docs/beginners_guide.html)

_____
Alternative Ressources used
- [Getting started with dockerfile](https://docker-community-leaders.github.io/dockercommunity/docs/communityleaders/eventhandbooks/docker101/dockerfile/)
- [What is Dockerfile ? A step-by-step guide (2023)](https://www.simplilearn.com/tutorials/docker-tutorial/what-is-dockerfile)
- [Important instructions used in dockerfile](https://www.tutorialspoint.com/important-instructions-used-in-dockerfile)
- [Docker official documentation : Best practices for writing dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Docker official documentation : Packaging your software : Dockerfile](https://docs.docker.com/build/building/packaging/)
- [Docker Compose Tutorial: advanced Docker made simple](https://www.educative.io/blog/docker-compose-tutorial)
- [Github : Dumb init, PID 1 handler](https://github.com/Yelp/dumb-init)
