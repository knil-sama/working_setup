#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

brew install docker
brew install docker-compose
# download from dockerhub
sudo port install kubectl-1.15
sudo port select --set kubectl kubectl1.15
sudo port install helm-2.12
sudo port select --set helm helm2.12
sudo port install terraform
brew install kubectx
# gvm install
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
# ksd install 
gvm install go1.7
gvm use go1.7 --default
go get github.com/mfuentesg/ksd
brew install remind101/formulae/assume-role
