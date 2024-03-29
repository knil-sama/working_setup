#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-docker.html
docker pull amazon/aws-cli:latest
if ! grep -qF "alias aws" ~/.bashrc; then
    echo "alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'" >> ~/.bashrc
fi
docker pull docker.io/cuelang/cue:0.4.3
if ! grep -qF "alias cue" ~/.bashrc; then
    echo "alias cue='docker run --rm -it -v $(pwd):/tmp -w /tmp docker.io/cuelang/cue:0.4.3'" >> ~/.bashrc
fi
if ! [ -x "$(command -v sam)" ]; then
    wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip
    unzip aws-sam-cli-linux-x86_64.zip -d sam-installation && rm aws-sam-cli-linux-x86_64.zip 
    sudo ./sam-installation/install
    rm -R ./sam-installation
fi
