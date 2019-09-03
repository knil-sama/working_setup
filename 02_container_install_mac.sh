#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

sudo port install docker
pip3 install docker-compose --user
sudo port install kubectl-1.15
sudo port select --set kubectl kubectl1.15
sudo port install helm-2.12
sudo port select --set helm helm2.12
sudo port install kubectx
brew install remind101/formulae/assume-role
