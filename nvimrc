"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

" Required:
set runtimepath^=/Users/cemaleker/.dein.vim/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.dein.vim'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/vimshell')

" UI
" call dein#add('altercation/vim-colors-solarized')
call dein#add('morhetz/gruvbox')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('Shougo/deoplete.nvim')

" Navigation
call dein#add('easymotion/vim-easymotion')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('tpope/vim-vinegar')
call dein#add('tpope/vim-obsession')
call dein#add('mileszs/ack.vim')

" Git
call dein#add('tpope/vim-fugitive')

" Syntax
call dein#add('scrooloose/syntastic')
call dein#add('tpope/vim-surround')
call dein#add('scrooloose/nerdcommenter')
call dein#add('majutsushi/tagbar')
call dein#add('sheerun/vim-polyglot')
call dein#add('carlitux/deoplete-ternjs', { 'build': 'npm install -g tern' })
call dein#add('ternjs/tern_for_vim', { 'build': 'npm install' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

syntax enable
set background=dark
" colorscheme solarized
set nobackup
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→
if has("gui_running")
    set guifont=Meslo\ LG\ S\ DZ\ for\ Powerline:h12
endif

set tabstop=4
set shiftwidth=4

let mapleader="\<Space>"

""" Save with Space+w
nnoremap <Leader>w :w<CR>
nnoremap ; :

imap jk <Esc>
imap kj <Esc>

""" Copy / paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

set number
set relativenumber
nnoremap <Leader>tl :set list!<CR>
nnoremap <Leader>t :tabprev<CR>
nnoremap <Leader>t] :tabnext<CR>
nnoremap <Leader>[ :bprev<CR>
nnoremap <Leader>] :bnext<CR>

au FocusLost * :set number
au FocusGained * :set relativenumber

" Open file menu
nnoremap <Leader>o :CtrlP .<CR>
" Open buffer menu
nnoremap <Leader>b :CtrlPBuffer<CR>
" Open most recently used files
nnoremap <Leader>f :CtrlPMRUFiles<CR>

set laststatus=2
set ttimeoutlen=50

let g:gruvbox_italic=1
colorscheme gruvbox

let g:airline#extensions#tabline#enabled = 1

" airline symbols
let g:airline_theme = 'gruvbox'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

" TagBar
let g:tagbar_ctags_bin = "/usr/local/bin/ctags"

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal commentstring=//%s
autocmd FileType json setlocal shiftwidth=2 tabstop=2

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 1

" Close scratch window automatically
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Use deoplete.
let g:tern_request_timeout = 1
"let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

" tern go to definition
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" Ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

