" Pathogen
execute pathogen#infect()

" Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
"let g:airline_powerline_fonts = 1
set ttimeoutlen=10

" Dracula
syntax on
color dracula

" General neccessities
filetype plugin indent on
let mapleader = " "
set relativenumber
" Tabs
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
autocmd Filetype sh setlocal sts=2 sw=2 et
autocmd Filetype html setlocal tw=80 spell spelllang=en_us
" Other
vnoremap . :norm.<CR>
set hlsearch
set encoding=utf-8
set splitbelow
set splitright
