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
sudo apt-get install -y npm git chromium-browser 
# install slack
if ! [ -x "$(command -v slack)" ]; then
  wget https://downloads.slack-edge.com/releases/linux/4.28.184/prod/x64/slack-desktop-4.28.184-amd64.deb
  sudo apt install ./slack-desktop-4.28.184-amd64.deb
  rm slack-desktop-4.28.184-amd64.deb
fi
# install zoom
if ! [ -x "$(command -v zoom)" ]; then
  wget https://zoom.us/client/latest/zoom_amd64.deb
  sudo apt install ./zoom_amd64.deb
  rm zoom_amd64.deb
fi
# install java
sudo apt install -y openjdk-11-jdk
# plantuml install
sudo apt-get install -y plantuml
# vscode install
if ! [ -x "$(command -v code)" ]; then
  wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 -O code.deb
  sudo apt install ./code.deb
  code --install-extension DavidAnson.vscode-markdownlint
  code --install-extension yzhang.markdown-all-in-one
  code --install-extension redhat.vscode-yaml
  code --install-extension GitHub.vscode-pull-request-github
  code --install-extension janjoerke.jenkins-pipeline-linter-connector
  code --install-extension mhutchie.git-graph
  code --install-extension ms-azuretools.vscode-docker
  code --install-extension ms-pyright.pyright
  code --install-extension ms-python.python
  code --install-extension njpwerner.autodocstring
  code --install-extension ms-python.vscode-pylance
  code --install-extension bungcip.better-toml
  code --install-extension esbenp.prettier-vscode
  code --install-extension ms-toolsai.jupyter
  code --install-extension ms-toolsai.jupyter-keymap
  code --install-extension ms-toolsai.jupyter-renderers
  code --install-extension ms-vscode-remote.remote-containers
  code --install-extension ms-vscode.makefile-tools
  code --install-extension ryanluker.vscode-coverage-gutters
  code --install-extension shyykoserhiy.git-autoconfig
  code --install-extension VisualStudioExptTeam.vscodeintellicode
  code --install-extension alessandrosangalli.mob-vscode-gui
fi
# nvm
if ! [ -x "$(command -v nvm)" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
  source ~/.bashrc
  nvm install node
  nvm use node
fi
if ! [ -x "$(command -v devcontainers)" ]; then
  npm install -g @devcontainers/cli
fi
# git commitizen
sudo npm install -g commitizen
#python
sudo apt-get install -y python3-pip
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install poetry black
# mob tool
if ! [ -x "$(command -v mob)" ]; then
  curl -sL install.mob.sh | sudo sh
  sudo apt-get install -y gnustep-gui-runtime
fi
rm *.deb
