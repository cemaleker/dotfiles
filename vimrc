set encoding=utf-8
if has('gui_running')
  set guifont=Source\ Code\ Pro\ for\ Powerline:h13

  set list listchars=tab:▶‒,nbsp:∙,trail:∙,extends:▶,precedes:◀
  let &showbreak = '↳'
else
  set list listchars=tab:>-,nbsp:.,trail:.,extends:>,precedes:<
  let &showbreak = '^'
endif

set tabstop=2
set shiftwidth=2
set expandtab


map ; :
noremap ;; ;

