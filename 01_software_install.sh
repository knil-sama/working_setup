#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

apt-get update
apt-get upgrade -y
apt-get install -y git
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
apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y sublime-text
# setup skype
wget https://repo.skype.com/latest/skypeforlinux-64.deb
dpkg -i skypeforlinux-64.deb
apt --fix-broken install
apt install -f
# setup slack
apt-get install libgnome-keyring0 gir1.2-gnomekeyring-1.0
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.2.1-amd64.deb
dpkg -i slack-desktop-3.2.1-amd64.deb
apt install -f
apt-get install --fix-broken -y steam git snapd chromium-browser 
# bug on ubuntu 18.04 don't use snap install --classic slack
snap install --classic vscode
snap install spotify
rm *.deb*
