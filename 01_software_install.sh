#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git curl
# oh my git
# if ! grep -qF "oh-my-git/prompt.sh" ~/.bashrc; then
#   # Copy the awesome fonts to ~/.fonts
#   cd /tmp
#   rm -Rf awesome-terminal-fonts
#   git clone http://github.com/gabrielelana/awesome-terminal-fonts
#   cd awesome-terminal-fonts
#   git checkout patching-strategy
#   mkdir -p ~/.fonts
#   cp patched/*.ttf ~/.fonts
#   # update the font-info cache
#   sudo fc-cache -fv ~/.fonts
#   git clone https://github.com/arialdomartini/oh-my-git.git ~/.oh-my-git && echo source ~/.oh-my-git/prompt.sh >> ~/.bashrc
# fi
#sublime text
if ! [ -x "$(command -v subl)" ]; then
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
  echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | sudo tee /etc/apt/sources.list.d/sublime-text.sources
  sudo apt-get update
  sudo apt-get install -y sublime-text
fi
sudo apt-get install -y npm git chromium-browser 
# install slack
if ! [ -x "$(command -v slack)" ]; then
  SLACK_VERSION=4.33.73
  wget https://downloads.slack-edge.com/releases/linux/${SLACK_VERSION}/prod/x64/slack-desktop-${SLACK_VERSION}-amd64.deb
  sudo apt install ./slack-desktop-${SLACK_VERSION}-amd64.deb
  rm -f slack-desktop-${SLACK_VERSION}-amd64.deb
fi
# install zoom
if ! [ -x "$(command -v zoom)" ]; then
  wget https://zoom.us/client/latest/zoom_amd64.deb
  sudo apt install -y ./zoom_amd64.deb
  rm -f zoom_amd64.deb
fi
# install java
sudo apt install -y openjdk-11-jdk
# plantuml install
sudo apt-get install -y plantuml
# codium install
if ! [ -x "$(command -v codium)" ]; then
  wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
  sudo sh -c 'echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main" > /etc/apt/sources.list.d/vscodium.list'
  sudo apt update
  sudo apt install -y codium
  code --install-extension DavidAnson.vscode-markdownlint
  code --install-extension yzhang.markdown-all-in-one
  code --install-extension redhat.vscode-yaml
  code --install-extension GitHub.vscode-pull-request-github
  # code --install-extension janjoerke.jenkins-pipeline-linter-connector
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
#python uv
curl -LsSf https://astral.sh/uv/install.sh | sh
rm -f *.deb
if ! [ -x "$(command -v cargo)" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
sudo apt install -y pre-commit
# nvm
if ! [ -d "/usr/local/lib/node_modules" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
  sudo mkdir -p /usr/local/lib/node_modules
  sudo chown -R $USER /usr/local/lib/node_modules
  echo "reload terminal to continue"
fi
if ! [ -x "$(command -v bruno)" ]; then
  # Bruno install
  # Create keyrings directory 
  sudo mkdir -p /etc/apt/keyrings
  # Update and install GPG and curl 
  sudo apt update && sudo apt install gpg curl 
  # List existing keys (optional) 
  sudo gpg --list-keys 
  # Add the Bruno repository key 
  curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9FA6017ECABE0266" | gpg --dearmor | sudo tee /etc/apt/keyrings/bruno.gpg > /dev/null 
  # Set permissions for the GPG key file 
  sudo chmod 644 /etc/apt/keyrings/bruno.gpg 
  # Add the Bruno repository 
  echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/bruno.gpg] http://debian.usebruno.com/ bruno stable" | sudo tee /etc/apt/sources.list.d/bruno.list 
  # Update and install Bruno 
  sudo apt-get update
  sudo apt-get install bruno -y
fi
# need to be run outside of script nvm install node
# need to be rn outside of script nvm use node
if ! [ -x "$(command -v devcontainers)" ]; then
  sudo npm install -g @devcontainers/cli
fi        