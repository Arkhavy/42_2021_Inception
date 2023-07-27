# sudo commands and mini documentation
Switching to root allows less security but the commands can be sent without the keyword
Sudo is more secure than root shell because it is a temporary root privileges while root shell is a permanent not tracked one

# command to switch as root
su -
<password>

# change password
passwd <password>

# use a command as another user
sudo -u <user> <command> <arguments>

# Add a user in a group (Root only command)
usermod -aG <group> <username>
Example : usermode -aG sudo arkhavy

# List all user of a group
getent group <group_name>
Example : getent group sudo

# Adding the user to the sudoers file directly:
Pros:
	More control over individual user privileges.
	Can assign different levels of sudo access to different users.
Cons:
	Requires editing the sudoers file, which can be error-prone if not done correctly.
	If the sudoers file is modified incorrectly, it can lead to system instability or security vulnerabilities.

# Adding the user to the sudo group:
Pros:
	Simpler and less error-prone process.
	Allows multiple users to have the same level of sudo access.
Cons:
	Less fine-grained control over individual user privileges.
	All users in the sudo group have the same level of sudo access.

It's important to note that you should exercise caution when granting sudo privileges to users, as it gives them significant control over the system.
Only grant sudo access to trusted users who need it for administrative tasks.

______________________________________________________________________________________________________________

# apt package

# apt update:
This command updates the package lists for upgrades and new package installations.
It retrieves the latest information about available packages from the configured software repositories.
It is recommended to run this command before installing or upgrading packages.
Example: sudo apt update

# apt upgrade:
This command upgrades the installed packages on your system to their latest versions.
It installs new versions of packages if available.
It is recommended to run apt update before running apt upgrade to ensure that the package lists are up to date.
Example: sudo apt upgrade

# apt install:
This command is used to install new packages on your system.
You can specify the package name(s) you want to install after the command.
Apt will automatically resolve dependencies and install the necessary packages.
Example: sudo apt install package_name

# apt remove:
This command is used to remove a package from your system.
It removes the binaries of the package but leaves the configuration files intact.
If you reinstall the package later, it will have the same configuration files.
Example: sudo apt remove package_name

# apt purge: 
This command completely removes a package and its configuration files from your system.
It is useful when you want to remove all traces of a program, including its configuration files, and start fresh.
Example: sudo apt purge package_name

# apt list: 
This command allows you to list packages based on different criteria:
	apt list --upgradable: Lists packages that have a newer version available for upgrade.
	apt list --installed: Lists all the packages installed on your system.
	apt list --all-versions: Lists all the packages available for your system.
	Example: apt list --upgradable

# apt-cache search:
This command is used to search for packages based on a given search term.
It searches the package database for package names and descriptions that match the search term.
Example: apt-cache search search_term

______________________________________________________________________________________________________________

# Updating and Upgrading: same between apt and apt-get

# apt-get update
This command updates the package cache and checks for broken dependencies.
It is important to run this command before installing any packages to ensure that the packages you install are up-to-date.

# apt-get upgrade
This command upgrades the installed packages to their latest versions.
It is recommended to run apt-get update before running this command.

# apt-get dist-upgrade
This command is similar to apt-get upgrade, but it can also install new packages and remove old ones automatically.
However, be careful when using this command as it may remove some packages that you still need on your system.

# Installing Packages:

# apt-get install <package_name>
This command installs a specific package.
Replaceckage_name with the name of the software package you intend to install.
If you are unsure of the exact package name, you can type in the first few letters and press TAB to see the available options.

# apt-get install <package_name> <version_number>
This command installs a specific version of a package.
It can be useful if you need to install a specific version for compatibility reasons.

# apt-get install <package_name1> <package_name2> <package_name3>
This command installs multiple packages at the same time with a single command.
This can be useful for installing all the necessary software for a project in one step.

# Removing Packages:

# apt-get remove <package_name>
This command removes a specific package from the system, but leaves its configuration files intact.

# apt-get purge <package_name>
This command removes a specific package along with its configuration files.

# apt-get autoremove
This command removes unnecessary packages that were automatically installed to satisfy dependencies for other packages.

# Searching for Packages:

# apt-cache search <search_term>
This command searches for packages that match a specific search term.
It can be useful when you are looking for a package but don't know its exact name.

# apt-cache show <package_name>
This command displays detailed information about a specific package, including its description, dependencies, and size.

______________________________________________________________________________________________________________

# Dockerfile

-----
Structure d'un dockerfile
Un dockerfile permettra de lancer notre application et toutes les instructions nécessaire au bon fonctionnement de celle-ci

```Dockerfile
# This use dockerhub to get the right image
FROM <base_image>:<distribution>

# Copy all the program files from a directory in a given directory that can be created thanks to COPY
COPY <current_dir> <destination_dir>

# This defines the default directory where CMD is executed
WORKDIR <destination_dir>

# Here to execute commands
CMD <launch application command line>

```
<!-- This command is used to create an image -->
<!-- flag -t in this command is used to give a tag to identify the package -->
-> docker build -t <package_name_tag> <dockerfile_dir>

<!-- This command is used to see any currently existing images -->
<!-- We should see the image built with the previous command if everything worked correctly -->
-> docker image ls
<!-- This flag only display image IDs instead of the full list -->
-> docker image ls -q
<!-- This flag displays stopped image as well -->
-> docker image ls -a

<!-- remove image -->
-> docker image rm <package_name_tag> or <image_ID>
<!-- If images are running or are in containers, this will throw an error -->
<!-- You must remove containers first by using the container command line -->
<!-- You cannot remove running containers unless forcing the rm with -f or stopping the container first -->
-> docker image rm $(image ID list)

<!-- This commmand is used to run an existing image already built -->
<!-- If the image is not already on the machine, it will call the pull command line itself -->
-> docker run <package_name_tag>
<!-- interactive mode flag, to interact with the container while it is running -->
-> docker run -it <package_name_tag>

<!-- This command is used to pull an existing repository from dockerhub -->
<!-- We need to use it in order to run it if the package is not already on the machine -->
-> docker pull <repository_name>

<!-- This command is used to see currently running container -->
-> docker ps
<!-- this flag is used to see stopped containers as well as running ones -->
-> docker ps -a

# if you see a command line like docker image <cmd>, the cmd given works with docker container and docker volume too

______________________________________________________________________________________________________________

# Docker Compose
Docker Compose
Docker Networking
Database migration
Running automated tests

<!-- Display the current version of docker-compose -->
<!-- docs.docker.com/compose/install -->
-> docker-compose --version

<!-- starts downloading, extracting, installing, testing and launching the application -->
-> docker-compose up

_____

YML and JSON format
Docker Compose tutorial 9min in
https://www.youtube.com/watch?v=HG6yIjZapSA