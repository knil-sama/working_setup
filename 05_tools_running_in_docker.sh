#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-docker.html
docker pull amazon/aws-cli:latest
if ! grep -qF "alias aws" ~/.bashrc; then
    echo "alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'" > ~/.bashrc
fi
docker pull docker.io/cuelang/cue:0.4.3
if ! grep -qF "alias aws" ~/.bashrc; then
    echo "alias cue='docker run --rm -it -v $(pwd):/tmp -w /tmp docker.io/cuelang/cue:0.4.3'" > ~/.bashrc
fi


