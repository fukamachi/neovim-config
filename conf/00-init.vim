if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
let g:python_host_prog = $PYENV_ROOT.'/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT.'/versions/neovim3/bin/python'

let g:dein#auto_recache = 1

if dein#load_state('~/.vim/dein')
  call dein#begin('~/.vim/dein')

  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('vim-scripts/vim-auto-save')
  call dein#add('Shougo/denite.nvim')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('thinca/vim-quickrun')
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  call dein#add('plasticboy/vim-markdown')
  call dein#add('junegunn/goyo.vim')
  call dein#add('previm/previm')
  call dein#add('powerman/vim-plugin-AnsiEsc')
  call dein#add('iberianpig/tig-explorer.vim')

  "Color Scheme
  call dein#add('sonph/onehalf', {'rtp': 'vim/'})
  call dein#add('vim-airline/vim-airline')

  "Common Lisp
  "call dein#add('fukamachi/vlime', {'rtp': 'vim/', 'on_ft': 'lisp', 'rev': 'develop'})
  call dein#add('~/Programs/etc/vlime/', {'rtp': 'vim/', 'on_ft': 'lisp'})
  call dein#add('guns/vim-sexp')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')

  "Python
  call dein#add('Vigemus/iron.nvim')
  call dein#add('dense-analysis/ale')  "This plugin is not specific for Python, though.

  call dein#end()
  call dein#save_state()
endif

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

set autoindent         "改行時に自動でインデントする
set tabstop=2          "タブを何文字の空白に変換するか
set shiftwidth=2       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set splitright         "画面を縦分割する際に右に開く
set clipboard=unnamed  "yank した文字列をクリップボードにコピー
set hls                "検索した文字をハイライトする
set noswapfile

set cursorline
autocmd BufEnter * setlocal cursorline
autocmd BufLeave * setlocal nocursorline
highlight CursorLine cterm=NONE ctermbg=DarkGray

set wildmenu
set wildmode=longest:full,full
set pumheight=10
set autoread

let g:netrw_localrmdir="rm -r"

"Edit init.vim
function! Config()
    edit ~/.config/nvim/conf/
endfunction
command! Config call Config()

function! FileTypeConfig()
  if &filetype != ''
    let filename = "~/.config/nvim/ftplugin/" . &filetype . ".vim"
    execute 'edit' filename
  endif
endfunction
command! FileTypeConfig call FileTypeConfig()
