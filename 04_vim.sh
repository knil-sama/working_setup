# From https://realpython.com/vim-and-python-a-match-made-in-heaven/
sudo apt-get install vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "set nocompatible
filetype off

\" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

\" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

\" add all your plugins here, note older versions of Vundle used Bundle instead of Plugin, All of your Plugins must be added before the following line

call vundle#end()
filetype plugin indent on" >  ~/.vimrc
