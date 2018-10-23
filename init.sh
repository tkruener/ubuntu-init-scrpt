#!/bin/bash
cd $HOME
# Script to install applications on a fresh ubuntu installation
function echored {
 RED='\033[0;31m'
 NC='\033[0m'
 echo -e $RED $@ $NC
}
echored UPDATE
apt -y update
echored UPGRADE
apt -y upgrade
# Standards
echored STANDARDS
apt -y install vim python make vlc jq httpie keepassx htop gimp snapd nodejs tree sl git curl \
apt-transport-https python3 python3-pip python-pip xclip
# Yarn
echored YARN
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt update && sudo apt -y install yarn
# Java
echored JAVA
apt -y install openjdk-11-jre openjdk-11-jdk openjdk-11-demo openjdk-11-doc openjdk-11-jre-headless openjdk-11-source
# Git
echored GIT CONFIG
git config --global user.name Tobias Krüner
git config --global user.email tobi.kruner@arcor.de
# Docker
echored DOCKER 
apt -y install apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-key fingerprint 0EBFCD88
apt -y update
apt -y install docker-ce
groupadd docker
sudo usermod -aG docker $USER
# Docker compose
echored Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
#Aws CLI
echored AWS CLI
apt -y install awscli
#Ask cli (alexa stuff)
echored ASK CLI
yarn global add node-gyp ask-cli
#Zsh & Oh my zsh
echored zsh and oh my zsh
apt -y install zsh
sudo -u $USER chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#Go
echored Go
apt -y install golang-1.10-go
#Install terraform
echored terraform
wget -nc -P /tmp/terraform https://releases.hashicorp.com/terraform/0.11.9/terraform_0.11.9_linux_amd64.zip
unzip -o /tmp/terraform/terraform_0.11.9_linux_amd64.zip -d /usr/local/bin 
#IntelliJ
wget -nc -P /tmp/ideaIU https://download-cf.jetbrains.com/idea/ideaIU-2018.2.5.tar.gz
mkdir /opt/ideaIU
tar -xvzf /tmp/ideaIU/ideaIU-2018.2.5.tar.gz -C /opt/ideaIU
if ! grep -Fxq opt/ideaIU/idea-IU-182.4892.20/bin .profile
then
    echo 'PATH="$PATH:opt/ideaIU/idea-IU-182.4892.20/bin"' >> .profile
fi
/opt/ideaIU/idea-IU-182.4892.20/bin/idea.sh





