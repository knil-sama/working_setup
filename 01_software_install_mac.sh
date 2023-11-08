#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# setup to use touch id with sudo

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git curl
brew cask install sublime-text
brew cask install steam
brew cask install slack
brew install python
pip3 install awscli --upgrade --user
sudo port install jq
