#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

apt-get update
apt-get upgrade -y
# oh my git
# Copy the awesome fonts to ~/.fonts
cd /tmp
git clone http://github.com/gabrielelana/awesome-terminal-fonts
cd awesome-terminal-fonts
git checkout patching-strategy
mkdir -p ~/.fonts
cp patched/*.ttf ~/.fonts

# update the font-info cache
sudo fc-cache -fv ~/.fonts
git clone https://github.com/arialdomartini/oh-my-git.git ~/.oh-my-git && echo source ~/.oh-my-git/prompt.sh >> ~/.bashrc
# setup skype
wget https://repo.skype.com/latest/skypeforlinux-64.deb
dpkg -i skypeforlinux-64.deb
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
