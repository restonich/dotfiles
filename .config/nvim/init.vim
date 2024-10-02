"sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

set number
set clipboard=unnamedplus
set colorcolumn=80,100

set noexpandtab
set tabstop=8
set shiftwidth=8
set softtabstop=0

set mouse=a

syntax on
set cursorline

set termguicolors
set background=dark
colorscheme gruvbox
