#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

if ! [ -x "$(command -v docker)" ]; then
   # setup for docker*
   sudo apt-get remove docker docker.io containerd runc
   sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
   sudo mkdir -p /etc/apt/keyrings
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --batch --yes -o /etc/apt/keyrings/docker.gpg
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   # Next, point the package manager to the official Docker repository
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   sudo apt-get update
   sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
   sudo apt-get install -y virtualbox
   sudo usermod -a -G docker $USER
fi
if ! [ -x "$(command -v kubectl)" ]; then
   echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
   # to solve warning https://www.omgubuntu.co.uk/2022/06/fix-apt-key-deprecation-error-on-ubuntu
   # sudo apt-key list => last two 4char second line
   # sudo apt-key export 8A8F901A | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/kubernetes.gpg
   sudo curl -fsSL  https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
   sudo apt-get update
   sudo apt-get install -y kubelet kubeadm kubectl
fi
snap install kubectx --classic
if ! [ -x "$(command -v helm)" ]; then
   curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
   sudo apt-get install apt-transport-https --yes
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
   sudo apt-get update 2>&1 | sed -ne 's?^.*NO_PUBKEY ??p' | xargs -r -- sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys || true
   sudo apt-get install -y helm
fi
if ! [ -x "$(command -v docker compose)" ]; then
   # pipx install docker-compose had issue running it with pyyaml, try using v2
   mkdir -p ~/.docker/cli-plugins
   # download the CLI into the plugins directory
   curl -sSL https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
   # make the CLI executable
   chmod +x ~/.docker/cli-plugins/docker-compose
   # works using docker compose now
fi
