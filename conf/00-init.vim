if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/dein')
  call dein#begin('~/.vim/dein')

  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('vim-scripts/vim-auto-save')
  call dein#add('Shougo/denite.nvim')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('thinca/vim-quickrun')
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  call dein#add('plasticboy/vim-markdown')

  "Color Scheme
  call dein#add('sonph/onehalf', {'rtp': 'vim/'})
  call dein#add('vim-airline/vim-airline')

  "Common Lisp
  call dein#add('fukamachi/vlime', {'rtp': 'vim/', 'on_cmd': ['VlimeStart', 'VlimeQlotExec'], 'rev': 'develop'})
  call dein#add('guns/vim-sexp')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')

  call dein#end()
  call dein#save_state()
endif
