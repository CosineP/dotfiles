" plug-vim (New, adding to here from now on)
call plug#begin()

Plug 'Chiel92/vim-autoformat'
" TODO: is this one https://github.com/jiangmiao/auto-pairs better?
Plug 'ervandew/matchem'
" Plug 'Valloric/YouCompleteMe' " Need??
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'brooth/far.vim' " Need?
Plug 'scrooloose/nerdtree'
Plug 'jlfwong/vim-mercenary'
Plug 'leafgarland/typescript-vim'
Plug 'quabug/vim-gdscript'
Plug 'djoshea/vim-autoread'
Plug 'severin-lemaignan/vim-minimap'
Plug 'dracula/vim'
Plug 'nightsense/strawberry'
Plug 'rking/ag.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'tomtom/tcomment_vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'lepture/vim-jinja'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tomlion/vim-solidity'
Plug 'dart-lang/dart-vim-plugin'
Plug 'andreshazard/vim-freemarker'
Plug 'ron-rs/ron.vim'
Plug 'ElmCast/elm-vim'
Plug 'briancollins/vim-jst'
Plug 'pangloss/vim-javascript'
Plug 'kelwin/vim-smali'
Plug 'vimwiki/vimwiki'
Plug 'tmhedberg/matchit'
Plug 'vim-scripts/Colortest'
Plug 'zah/nim.vim'

call plug#end()

" Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set ttimeoutlen=0
let g:airline_theme='molokai'
" let g:airline_theme='zenburn' "(a more minimalist option)

" Deocomplete
let g:deoplete#enable_at_startup = 1

" Fix nvim not escaping insert mode fast enough
set timeout
set timeoutlen=750
set ttimeoutlen=250
"NeoVim handles ESC keys as alt+key, set this to solve the problem
if has('nvim')
 set ttimeout
 set ttimeoutlen=0
endif

" Auto-pairs
let g:AutoPairsFlyMode = 1

" Syntax / Color
syntax on
set t_Co=256 
color strawberry-light

" General neccessities
let mapleader = " "
set number relativenumber
set hidden
set so=5

" This is buggy sometimes, so I'm not sure I want it
" autocmd VimEnter * :Minimap

" vim-elm settings
let g:elm_format_autosave = 0

" Mappings
vnoremap . :norm.<CR>
nnoremap Y y$
nnoremap c- ct_
nnoremap c_ cT_
" This is kinda stupid but whatever
nnoremap <F5> :term<Up><CR>
nnoremap <leader>D dt;
nnoremap <leader>C ct;
nnoremap <leader>$ $h
nmap <F8> :TagbarToggle<CR>

" General neccessities
let mapleader = " "
set number relativenumber
set hidden
" 2 Spaces
set tabstop=2
set softtabstop=0 expandtab
set shiftwidth=2
set smarttab
autocmd Filetype sh            setlocal sts=2 sw=2 et
autocmd Filetype html          setlocal tw=80 spell spelllang=en_us
autocmd Filetype markdown      setlocal tw=80 spell spelllang=en_us
autocmd Filetype asciidoc      setlocal tw=80 spell spelllang=en_us
autocmd BufRead  /tmp/jn       setlocal tw=80 spell spelllang=en_us
autocmd BufRead  ~/journal.txt setlocal tw=80 spell spelllang=en_us
" Other
set hlsearch
set encoding=utf-8
set splitbelow
set splitright
set mouse=a

" Ctrl-P settings
let g:ctrlp_custom_ignore = 'target'

