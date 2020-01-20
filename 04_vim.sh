sudo apt-get install -y neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#curl -sL install-node.now.sh/lts | sudo bash
echo -n "call plug#begin('~/.vim/plugged')
\"Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
\" Or build from source code by use yarn: https://yarnpkg.com
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}" > ~/.vimrc
#https://github.com/junegunn/vim-plug/issues/741
