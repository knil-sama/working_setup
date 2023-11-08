#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# setup to use touch id with sudo

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# run twice solve potential rules issues ?!
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> /Users/clement.demonchy/.zprofile
eval "$(/usr/local/bin/brew shellenv)"
brew install git curl
brew install --cask sublime-text
pip3 install awscli --upgrade --user
brew install --cask google-chrome
# todo jq
# todo
# vscode install
if ! [ -x "$(command -v code)" ]; then
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  sudo apt install -y apt-transport-https
  sudo apt update
  sudo apt install -y code
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
#python
sudo apt-get install -y python3-pip python3-venv pipx
pipx ensurepath
pipx install black
pipx install poetry
# mob tool
if ! [ -x "$(command -v mob)" ]; then
  curl -sL install.mob.sh | sudo sh
  sudo apt-get install -y gnustep-gui-runtime
fi
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
# need to be run outside of script nvm install node
# need to be rn outside of script nvm use node
if ! [ -x "$(command -v devcontainers)" ]; then
  sudo npm install -g @devcontainers/cli
fi
# git commitizen
sudo npm install -g commitizen
