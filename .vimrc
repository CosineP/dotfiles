" Pathogen (Phasing out)
execute pathogen#infect()

" plug-vim (New, adding to here from now on)
call plug#begin()

Plug 'Chiel92/vim-autoformat'
" TODO: is this one https://github.com/jiangmiao/auto-pairs better?
Plug 'ervandew/matchem'

call plug#end()

" Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
"let g:airline_powerline_fonts = 1
set ttimeoutlen=10

" Auto-pairs
let g:AutoPairsFlyMode = 1

" Dracula
syntax on
color dracula

" Mappings
vnoremap . :norm.<CR>
nnoremap Y y$

" General neccessities
let mapleader = " "
set relativenumber
" Tabs
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
autocmd Filetype sh      setlocal sts=2 sw=2 et
autocmd Filetype html    setlocal tw=80 spell spelllang=en_us
autocmd BufRead  /tmp/jn setlocal tw=80 spell spelllang=en_us
" Other
set hlsearch
set encoding=utf-8
set splitbelow
set splitright
