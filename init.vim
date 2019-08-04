" dein.vimによるプラグイン管理
if &compatible
  set nocompatible
endif

" dein.vimのclone先を指定する
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

" 補完、スニペット
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')

" その他必要なプラグインはこちらに追加する
call dein#add('fukamachi/vlime', {'rtp': 'vim/'})
call dein#add('kovisoft/paredit')
call dein#add('sonph/onehalf', {'rtp': 'vim/'})
call dein#add('cocopon/iceberg.vim')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-scripts/vim-auto-save')
call dein#add('Shougo/denite.nvim')

call dein#end()

let mapleader=","
let maplocalleader=","

set autoindent         "改行時に自動でインデントする
set tabstop=2          "タブを何文字の空白に変換するか
set shiftwidth=2       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set splitright         "画面を縦分割する際に右に開く
set clipboard=unnamed  "yank した文字列をクリップボードにコピー
set hls                "検索した文字をハイライトする

set wildmenu
set wildmode=longest,full

"%%でアクティブファイルのディレクトリを展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"Terminal Mode
tnoremap <silent> <ESC> <C-\><C-n>

autocmd BufRead,BufNewFile *.asd set filetype=lisp

"カラースキーマ
colorscheme onehalfdark
autocmd ColorScheme * highlight Normal ctermfg=grey ctermbg=black
autocmd ColorScheme * highlight Comment ctermfg=33
let g:airline_powerline_fonts = 1

let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

nmap <M-r> :Denite file/old buffer<CR>
nmap <silent> <C-t> :<C-u>Denite file/rec<CR>
nmap <silent> <C-p><C-t> :<C-u>DeniteProject file/rec<CR>
nmap <silent> <C-u> :<C-u>Denite buffer<CR>
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction
