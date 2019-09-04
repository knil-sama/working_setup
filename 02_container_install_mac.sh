#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# download from dockerhub
sudo port install kubectl-1.15
sudo port select --set kubectl kubectl1.15
sudo port install helm-2.12
sudo port select --set helm helm2.12
sudo port install terraform
sudo port install kubectx
# ksd install 
brew install remind101/formulae/assume-role
