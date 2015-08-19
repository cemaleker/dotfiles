" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" Vimproc
NeoBundle 'Shougo/vimproc.vim', {
	\ 'build' : {
	\     'windows' : 'tools\\update-dll-mingw',
	\     'cygwin' : 'make -f make_cygwin.mak',
	\     'mac' : 'make -f make_mac.mak',
	\     'linux' : 'make',
	\     'unix' : 'gmake',
	\    },
	\ }

"""
"NeoBundle 'scrooloose/nerdcommenter'
"""

"""
NeoBundle 'Shougo/neocomplete.vim'

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#max_list = 30

" let g:neocomplete#sources#dictionary#dictionaries = {
"     \ 'default' : '',
"     \ }


" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " For no inserting <CR> key.
return pumvisible() ? neocomplete#close_popup() : "\<CR>"
return neocomplete#close_popup() . "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplete#close_popup()
" inoremap <expr><C-e>  neocomplete#cancel_popup()

" Close popup by <Space>.
" inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
"""

"""
NeoBundle 'Shougo/unite.vim'

let g:unite_source_history_yank_enable = 1

nnoremap <leader>Ub :<C-u>Unite -no-split -buffer-name=buffer buffer<CR>
"""

"""
NeoBundle 'bling/vim-airline'

let g:airline#extensions#tabline#enabled = 1

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline_symbols = {}
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.space = ' '
"""

"""
NeoBundle 'Shougo/vimfiler.vim'

let g:vimfiler_as_default_explorer = 1
"""

" NeoBundle 'Shougo/neomru.vim'
" NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'altercation/vim-colors-solarized'

NeoBundle 'scrooloose/syntastic'
NeoBundle 'majutsushi/tagbar'
" NeoBundle 'garyburd/go-explorer'
" NeoBundle 'tpope/vim-surround'
" NeoBundle 'tpope/vim-repeat'
" NeoBundle 'tpope/vim-unimpaired'
" NeoBundle 'tpope/vim-commentary'

NeoBundle 'fatih/vim-go'
NeoBundle 'garyburd/go-explorer'
" NeoBundle 'freitass/todo.txt-vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

set history=700
set autoread

set so=7
set wildmenu
set ruler
set cmdheight=2
set hid

set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set lazyredraw
set magic
set showmatch
set mat=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set clipboard=unnamed

set number
set relativenumber

syntax enable

color solarized
set background=dark

if has('gui_running')
  set guioptions=a
  set t_Co=256
endif

set encoding=utf8
set ffs=unix,dos,mac

set nobackup
set nowb
set noswapfile

set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

let mapleader="\<space>"
let maplocalleader="\<space>\<space>"

noremap ; :

map j gj
map k gk

inoremap kj <Esc>
inoremap jk <Esc>

inoremap <left>   <nop>
inoremap <right>  <nop>
inoremap <up>     <nop>
inoremap <down>   <nop>

nnoremap <left>   <nop>
nnoremap <right>  <nop>
nnoremap <up>     <nop>
nnoremap <down>   <nop>

" Always show status line
set laststatus=2

nnoremap <leader>ev :<C-u>e $MYVIMRC<CR>
nnoremap <leader>eg :<C-u>e $MYGVIMRC<CR>

cmap w!! w !sudo tee > /dev/null %

call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>of :<C-u>Unite -start-insert file_rec/async:!<CR>
nnoremap <leader>ob :<C-u>Unite -start-insert buffer<CR>

nnoremap <leader>bl :<C-u>bnext<CR>
nnoremap <leader>bh :<C-u>bprevious<CR>

echo "All set! Happy coding! >^.^<"


