"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=/Users/cemaleker/.dein.vim/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('/Users/cemaleker/.dein.vim'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

call dein#add('tpope/vim-sensible')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/vimshell')

" UI
call dein#add('altercation/vim-colors-solarized')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

" Navigation
call dein#add('easymotion/vim-easymotion')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('tpope/vim-vinegar')
call dein#add('tpope/vim-obsession')
call dein#add('mileszs/ack.vim')
call dein#add('mhinz/vim-grepper')

" Git
call dein#add('tpope/vim-fugitive')

" Syntax
call dein#add('scrooloose/syntastic')
call dein#add('tpope/vim-surround')
call dein#add('scrooloose/nerdcommenter')
call dein#add('majutsushi/tagbar')
call dein#add('Shougo/neocomplete.vim')
call dein#add('sheerun/vim-polyglot')
call dein#add('winstonwolff/ctags-javascript-coffeescript')

" Format
call dein#add('Chiel92/vim-autoformat')

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
if has("gui_running")
    set guifont=Input\ Mono:h13
endif

set expandtab
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

let g:airline#extensions#tabline#enabled = 1

" airline symbols
let g:airline_theme = 'wombat'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

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

" Neocomplete
"
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? "\<C-y><Space>" : "\<Space>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" Ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


" CtrlP Delete Buffer
let g:ctrlp_buffer_func = { 'enter': 'CtrlPBDelete' }

function! CtrlPBDelete()
  nnoremap <buffer> <silent> <c-@> :call <sid>DeleteMarkedBuffers()<cr>
endfunction

function! s:DeleteMarkedBuffers()
  " list all marked buffers
  let marked = ctrlp#getmarkedlist()

  " the file under the cursor is implicitly marked
  if empty(marked)
    call add(marked, fnamemodify(ctrlp#getcline(), ':p'))
  endif

  " call bdelete on all marked buffers
  for fname in marked
    let bufid = fname =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(fname, '\d\+'))
          \ : fnamemodify(fname[2:], ':p')
    exec "silent! bdelete" bufid
  endfor

  " refresh ctrlp
  exec "normal \<F5>"
endfunction

