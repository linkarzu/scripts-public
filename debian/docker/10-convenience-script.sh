#!/usr/bin/env bash

boldGreen="\033[1;32m"
boldYellow="\033[1;33m"
boldRed="\033[1;31m"
noColor="\033[0m"

printf "\nThis script will\n"
printf "1. Only install docker if not installed yet\n"
printf "2. Check you have sudo permissions\n"
printf "3. Show you the versions and ask you which one you want to install\n"
printf "4. Add your user to the docker group so you can run docker commands without sudo\n\n"

# Only execute the script if docker is NOT installed
if command -v docker &>/dev/null; then
	installedVersion=$(docker --version | cut -d ' ' -f 3 | tr -d ',')
	printf "${boldGreen}Docker version $installedVersion is already installed. Exiting script.${noColor}\n"
	exit 0
fi

# Check if the user has sudo permissions
if ! sudo -n true 2>/dev/null; then
	printf "${boldYellow}User $USER does not have sudo permissions.${noColor}\n"
	printf "${boldYellow}Fix that and try again${noColor}\n"
	exit 0
fi

outroMessage() {
	installedVersion=$(docker --version | cut -d ' ' -f 3 | tr -d ',')
	printf "\n\n${boldGreen}>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n${noColor}"
	printf "${boldGreen}docker $installedVersion installed and user $USER added to docker group\n${noColor}"
	printf "${boldYellow}Exit the shell and then run 'docker ps' to confirm\n${noColor}"
}

adduserToGroup() {
	# Create the docker group if it doesn't exists, if it does, nothing happens
	sudo groupadd docker 2>/dev/null

	# Add current user to the docker group
	sudo usermod -aG docker $USER

	# Verify that your user is part of the docker group
	if groups $USER | grep 'docker'; then
		printf "${boldGreen}Added $USER to the docker group${noColor}\n"
		outroMessage
	else
		if getent group docker >/dev/null 2>&1; then
			printf "${boldRed}User $USER is not part of the docker group.\n${noColor}"
			printf "${boldRed}- Make sure to add it\n${noColor}"
		else
			printf "${boldRed}The docker group does not exist.\n${noColor}"
			printf "${boldYellow}- To create the docker group and add the user to it, run one of the following commands\n${noColor}"
			printf "${boldYellow}  (depending on how groups are created on your distro):\n${noColor}"
			printf "${boldYellow}  - sudo addgroup docker && sudo usermod -aG docker $USER\n${noColor}"
			printf "${boldYellow}  - sudo groupadd docker && sudo usermod -aG docker $USER\n${noColor}"
		fi
	fi
}

downloadScript() {
	# Update package lists
	sudo apt-get update -y 2>&1 >/dev/null
	printf "\nUpdated package lists\n"

	# Download script
	curl -fsSL https://get.docker.com -o ~/install-docker.sh 2>&1 >/dev/null
}

printf "${boldGreen}Specify the docker version you want to install\n${noColor}"
printf "${boldGreen}- You can check this in other servers with 'docker --version'\n${noColor}"
printf "${boldGreen}- Or if running a swarm cluster with 'docker node ls'\n${noColor}"
printf "${boldGreen}- Find releases in 'https://docs.docker.com/engine/release-notes'\n${noColor}"
printf "${boldGreen}- Which comes from 'https://github.com/moby/moby/tags'\n${noColor}"

printf "\n${boldYellow}Displaying list of latest 15 versions\n${noColor}"
curl -s https://api.github.com/repos/moby/moby/tags | grep '"name"' | cut -d'"' -f4 | grep -E '^v' | grep -vE 'rc|beta' | tail -n 15

printf "\n${boldYellow}Leave blank if you want to install the latest version\n${noColor}"
read -p "Enter the Docker version to install (default -> latest): " userInput

printf "\n${boldYellow}Executing the downloaded script${noColor}\n"
if [ -z "$userInput" ]; then
	downloadScript
	# If no version is specified, latest stable is installed
	sudo sh ~/install-docker.sh
	# $? saves exit status of last executed command. Exit status 0 means success
	if [ $? -eq 0 ]; then
		adduserToGroup
	else
		printf "${boldRed}Failed to execute the Docker installation script.${noColor}\n"
		exit 1
	fi
else
	downloadScript
	sudo sh ~/install-docker.sh --version $userInput
	# $? saves exit status of last executed command. Exit status 0 means success
	if [ $? -eq 0 ]; then
		adduserToGroup
	else
		printf "${boldRed}Failed to execute the Docker installation script.${noColor}\n"
		printf "${boldRed}Check the version and try again.${noColor}\n"
		exit 1
	fi
fi
