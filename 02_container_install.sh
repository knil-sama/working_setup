#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# setup for docker*
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common lsb-core linux-image-generic linux-image-extra-virtual
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
# Next, point the package manager to the official Docker repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
# make my home computer crash wtf, use official .deb instead  apt-get install -y virtualbox
sudo apt-get install -y virtualbox
sudo snap install kubectl --classic
sudo snap install helm --classic
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.28.2/minikube-linux-amd64 && chmod +x minikube && mv minikube /usr/local/bin/
minikube start
chmod 774 /home/knil/.kube/config
pip3 install docker-compose
