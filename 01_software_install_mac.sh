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
brew install --cask google-chrome
brew install jq
brew install --cask visual-studio-code
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
# todo

#python
brew install pipx
pipx ensurepath # update PATH
pipx install black
pipx install poetry
pipx install pre-commit
pipx ensurepath # update PATH
brew install node
npm install -g @devcontainers/cli
