#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

apt-get update
apt-get upgrade -y
# setup skype
wget https://repo.skype.com/latest/skypeforlinux-64.deb
dpkg -i skypeforlinux-64.deb
apt install -f
# setup slack
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.2.1-amd64.deb
dpkg -i slack-desktop-3.2.1-amd64.deb
apt install -f
apt-get --fix-broken  install -y vim steam git snapd chromium-browser 
# bug on ubuntu 18.04 don't use snap install --classic slack
snap install --classic vscode
snap install spotify
rm *.deb*