#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# setup for docker*
apt-get install apt-transport-https ca-certificates curl software-properties-common lsb-core linux-image-generic linux-image-extra-virtual
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
      --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
 
# Next, point the package manager to the official Docker repository
sudo apt-add-repository \'deb https://apt.dockerproject.org/repo/ ubuntu-xenial main\'
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update
apt-get install -y docker-ce
# make my home computer crash wtf, use official .deb instead  apt-get install -y virtualbox
snap install kubectl --classic
rm -r /opt/kubectx && git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -fs /opt/kubectx/kubectx /usr/local/bin/kubectx
ln -fs /opt/kubectx/kubens /usr/local/bin/kubens
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.28.2/minikube-linux-amd64 && chmod +x minikube && mv minikube /usr/local/bin/
minikube start
chmod 774 /home/knil/.kube/config
