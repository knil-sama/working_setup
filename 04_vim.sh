#https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/
sudo apt-get install vim
pip3 install yapf jedi pynvim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo -n "call plug#begin('~/.vim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
let g:deoplete#enable_at_startup = 1
Plug 'sbdchd/neoformat'

"Python
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'

" For golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}

#call plug#end()" > ~/.vimrc
# PluginInstall not working in the end for neovim
#sudo curl -fLo /usr/local/bin/nvim --create-dirs https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
#sudo chmod 755 /usr/local/bin/nvim
#mkdir -p ~/.config/nvim
#curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#curl -sL install-node.now.sh/lts | sudo bash
#echo -n "call plug#begin('~/.local/share/nvim/plugged')
#\" For python
#Plug 'deoplete-plugins/deoplete-jedi'
#\" this one don't work https://github.com/zchee/nvim-go
#\" For golang
#Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
#call plug#end()" > ~/.config/nvim/init.vim
