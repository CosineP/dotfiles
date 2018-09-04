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
" Imported from .bundle
Plug 'dracula/vim'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'tomtom/tcomment_vim'
Plug 'vim-airline/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'lepture/vim-jinja'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tomlion/vim-solidity'
Plug 'dart-lang/dart-vim-plugin'
Plug 'nikvdp/ejs-syntax'
Plug 'andreshazard/vim-freemarker'
Plug 'briancollins/vim-jst'
Plug 'pangloss/vim-javascript'
Plug 'kelwin/vim-smali'
Plug 'vimwiki/vimwiki'
Plug 'tmhedberg/matchit'

call plug#end()

" Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set ttimeoutlen=0

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

" Dracula
syntax on
color dracula

" Mappings
vnoremap . :norm.<CR>
nnoremap Y y$
nnoremap <leader>D dt;
nnoremap <leader>C ct;
nnoremap <leader>$ $h
nmap <F8> :TagbarToggle<CR>

" General neccessities
let mapleader = " "
set number relativenumber
set hidden
" Tabs
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
autocmd Filetype sh            setlocal sts=2 sw=2 et
autocmd Filetype html          setlocal tw=80 spell spelllang=en_us
autocmd Filetype markdown      setlocal tw=80 spell spelllang=en_us
autocmd BufRead  /tmp/jn       setlocal tw=80 spell spelllang=en_us
autocmd BufRead  ~/journal.txt setlocal tw=80 spell spelllang=en_us
" Other
set hlsearch
set encoding=utf-8
set splitbelow
set splitright
set mouse=a
