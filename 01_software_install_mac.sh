#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# setup to use touch id with sudo

#sudo apt-get update
#sudo apt-get upgrade -y
sudo port install git curl 
# oh my git
git clone https://github.com/arialdomartini/oh-my-git.git ~/.oh-my-git && echo source ~/.oh-my-git/prompt.sh >> ~/.profile

brew cask install sublime-text
brew cask install steam
brew cask install slack
brew cask install skype
brew cask install java
brew install go
brew cask install spotify
brew install python
pip3 install awscli --upgrade --user
sudo port install jq
