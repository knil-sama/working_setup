#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git curl
# oh my git
if ! grep -qF "oh-my-git/prompt.sh" ~/.bashrc; then
  # Copy the awesome fonts to ~/.fonts
  cd /tmp
  rm -Rf awesome-terminal-fonts
  git clone http://github.com/gabrielelana/awesome-terminal-fonts
  cd awesome-terminal-fonts
  git checkout patching-strategy
  mkdir -p ~/.fonts
  cp patched/*.ttf ~/.fonts
  # update the font-info cache
  sudo fc-cache -fv ~/.fonts
  git clone https://github.com/arialdomartini/oh-my-git.git ~/.oh-my-git && echo source ~/.oh-my-git/prompt.sh >> ~/.bashrc
fi
#sublime text
if ! [ -x "$(command -v subl)" ]; then
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  sudo apt-get install -y apt-transport-https
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt-get update
  sudo apt-get install -y sublime-text
fi
sudo apt-get install -y npm git snapd chromium-browser
# install slack
sudo snap install slack
# install zoom
if ! [ -x "$(command -v zoom)" ]; then
  wget https://zoom.us/client/latest/zoom_amd64.deb
  sudo apt install ./zoom_amd64.deb
fi
# install java
sudo apt install -y openjdk-11-jdk
# plantuml install
sudo apt-get install -y plantuml
# vscode install
sudo snap install codium --classic
codium --install-extension DavidAnson.vscode-markdownlint
codium --install-extension yzhang.markdown-all-in-one
codium --install-extension redhat.vscode-yaml
codium --install-extension GitHub.vscode-pull-request-github
codium --install-extension janjoerke.jenkins-pipeline-linter-connector
codium --install-extension mhutchie.git-graph
codium --install-extension ms-azuretools.vscode-docker
codium --install-extension ms-pyright.pyright
codium --install-extension ms-python.python
codium --install-extension njpwerner.autodocstring
codium --install-extension ms-python.vscode-pylance
codium --install-extension bungcip.better-toml
codium --install-extension esbenp.prettier-vscode
codium --install-extension ms-toolsai.jupyter
codium --install-extension ms-toolsai.jupyter-keymap
codium --install-extension ms-toolsai.jupyter-renderers
codium --install-extension ms-vscode-remote.remote-containers
codium --install-extension ms-vscode.makefile-tools
codium--install-extension ryanluker.vscode-coverage-gutters
codium --install-extension shyykoserhiy.git-autoconfig
codium --install-extension VisualStudioExptTeam.vscodeintellicode
codium --install-extension ms-azuretools.vscode-docker
codium --install-extension matklad.rust-analyzer
codium --install-extension vadimcn.vscode-lldb
codium --install-extension serayuzgur.crates
codium --install-extension usernamehw.errorlens
# git commitizen
sudo apt-get install -y npm
sudo npm install -g commitizen
#python
sudo apt-get install -y python3-pip
sudo apt install -y pre-commit
rm *.deb
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
