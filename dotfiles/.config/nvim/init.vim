set number
set relativenumber
set cursorline
set clipboard=unnamedplus
set colorcolumn=81

set noexpandtab
set tabstop=8
set shiftwidth=8
set softtabstop=0

call plug#begin(stdpath('data') . '/plugged')

Plug 'arcticicestudio/nord-vim'

call plug#end()

set termguicolors
colorscheme nord

"let g:gruvbox_contrast_dark = 'soft'
"colorscheme gruvbox

