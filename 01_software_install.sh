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
  # to solve warning https://www.omgubuntu.co.uk/2022/06/fix-apt-key-deprecation-error-on-ubuntu
  # sudo apt-key list => last two 4char second line
  # sudo apt-key export 8A8F901A | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/sublime.gpg
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
sudo apt-get install -y python3-pip python3-venv
python3 -m pip install --user pipx
python3 -m pipx ensurepath
~/.local/bin/pipx install black
~/.local/bin/pipx install poetry
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
  npm install -g @devcontainers/cli
fi
# git commitizen
sudo npm install -g commitizen
