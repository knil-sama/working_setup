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
   # Next, point the package manager to the official Docker repository
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   sudo apt-get update
   sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
   sudo apt-get install -y virtualbox
   sudo usermod -a -G docker $USER
fi
if ! [ -x "$(command -v kubectl)" ]; then
   echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
   curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
   sudo apt-get update
   sudo apt-get install -y kubelet kubeadm kubectl
fi
snap install kubectx --classic
if ! [ -x "$(command -v helm)" ]; then
   sudo apt-get install apt-transport-https --yes
   curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
   echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
   sudo apt-get update
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
# troubleshooting some issue https://stackoverflow.com/questions/51342810/how-to-fix-dial-unix-var-run-docker-sock-connect-permission-denied-when-gro
sudo setfacl --modify user:$USER:rw /var/run/docker.sock
