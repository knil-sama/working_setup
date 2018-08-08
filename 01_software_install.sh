#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

apt-get update
apt-get upgrade -y
apt-get install -y vim steam git snapd chromium-browser
# bug on ubuntu 18.04 don't use snap install --classic slack, qlso scudcloud didn't work at all
snap install --classic vscode
snap install --classic skype
snap install spotify