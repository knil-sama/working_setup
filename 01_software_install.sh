#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

apt-get update
apt-get upgrade -y
apt-get install -y git curl
# oh my git
# Copy the awesome fonts to ~/.fonts
cd /tmp
rm -Rf awesome-terminal-fonts
git clone http://github.com/gabrielelana/awesome-terminal-fonts
cd awesome-terminal-fonts
git checkout patching-strategy
mkdir -p ~/.fonts
cp patched/*.ttf ~/.fonts

# update the font-info cache
sudo fc-cache -fv ~/.fonts
git clone https://github.com/arialdomartini/oh-my-git.git ~/.oh-my-git && echo source ~/.oh-my-git/prompt.sh >> ~/.bashrc
#sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
apt-get install -y apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y sublime-text
# setup skype
wget https://repo.skype.com/latest/skypeforlinux-64.deb
dpkg -i skypeforlinux-64.deb || apt --fix-broken install -y
apt install -f -y
# setup slack
apt-get install -y libgnome-keyring0 gir1.2-gnomekeyring-1.0
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.3.7-amd64.deb
dpkg -i slack-desktop-3.3.7-amd64.deb || apt --fix-broken install -y
apt install -f -y
apt-get install -y steam git snapd chromium-browser 
# install java
apt install -y openjdk-11-jdk
# go install and aws-role stuff
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
apt-get install -y golang bison
source /home/clement/.gvm/scripts/gvm
gvm install go1.7
gvm use go1.7 --default
go get -u github.com/remind101/assume-role
# plantuml install
ap-get install -y plantuml
apt-get install -y awscli
snap install --classic vscode
snap install spotify
#python
apt-get install -y python3-pip
rm *.deb*
