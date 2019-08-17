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

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

set autoindent         "改行時に自動でインデントする
set tabstop=4          "タブを何文字の空白に変換するか
set shiftwidth=4       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set splitright         "画面を縦分割する際に右に開く
set clipboard=unnamed  "yank した文字列をクリップボードにコピー
set hls                "検索した文字をハイライトする
set noswapfile

set cursorline
autocmd BufEnter * setlocal cursorline
autocmd BufLeave * setlocal nocursorline

set wildmenu
set wildmode=longest:full,full

"Edit init.vim
function! Config()
    edit ~/.config/nvim/conf/
endfunction
command! Config call Config()
