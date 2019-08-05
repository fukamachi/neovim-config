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
call dein#add('fukamachi/vlime', {'rtp': 'vim/', 'on_cmd': ['VlimeStart', 'VlimeQlotExec']})
call dein#add('kovisoft/paredit')
call dein#add('sonph/onehalf', {'rtp': 'vim/'})
call dein#add('cocopon/iceberg.vim')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-scripts/vim-auto-save')
call dein#add('Shougo/denite.nvim')

call dein#end()

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

set autoindent         "改行時に自動でインデントする
set tabstop=4          "タブを何文字の空白に変換するか
set shiftwidth=4       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set splitright         "画面を縦分割する際に右に開く
set clipboard=unnamed  "yank した文字列をクリップボードにコピー
set hls                "検索した文字をハイライトする

set wildmenu
set wildmode=longest,full

"Command-Line Mode
"%%でアクティブファイルのディレクトリを展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>

"Terminal Mode
tnoremap <silent> <ESC> <C-\><C-n>

"カラースキーマ
colorscheme onehalfdark
autocmd ColorScheme * highlight Normal ctermfg=grey ctermbg=black
autocmd ColorScheme * highlight Comment ctermfg=33
let g:airline_powerline_fonts = 1

"AutoSave
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

"Denite
nnoremap <M-r> :Denite file/old buffer<CR>
nnoremap <silent> <C-t> :<C-u>Denite file/rec<CR>
nnoremap <silent> <C-p><C-t> :<C-u>DeniteProject file/rec<CR>
nnoremap <silent> <C-u> :<C-u>Denite buffer<CR>
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

nnoremap <M-x> :call<Space>
map q: :q

"Common Lisp
autocmd BufRead,BufNewFile *.asd set filetype=lisp
nnoremap <silent> <Leader>rr :call VlimeStart()<CR>
nnoremap <silent> <Leader>rq :call VlimeQlotExec()<CR>
nnoremap <silent> <M-i> :call vlime#plugin#SendToREPL()<CR>

"vlime-input-bufferで補完とインデントを有効に
augroup CustomVlimeInputBuffer
    autocmd!
    autocmd FileType vlime_input inoremap <silent> <buffer> <Tab> <C-r>=vlime#plugin#VlimeKey("tab")<CR>
    autocmd FileType vlime_input setlocal omnifunc=vlime#plugin#CompleteFunc
    autocmd FileType vlime_input setlocal indentexpr=vlime#plugin#CalcCurIndent()
augroup end

let g:vlime_cl_impl = "ros"
let g:vlime_cl_use_terminal = v:true
let g:vlime_indent_keywords = {"define-package": 1}

function! VlimeBuildServerCommandFor_ros(vlime_loader, vlime_eval)
    return ["rlwrap", "ros", "run",
               \ "--load", "~/.vim/dein/repos/github.com/fukamachi/vlime/lisp/load-vlime.lisp",
               \ "--eval", a:vlime_eval]
endfunction

function! VlimeBuildServerCommandFor_qlot(vlime_loader, vlime_eval)
    return ["rlwrap", "qlot", "exec", "ros", "run",
               \ "--load", "~/.vim/dein/repos/github.com/fukamachi/vlime/lisp/load-vlime.lisp",
               \ "--eval", a:vlime_eval]
endfunction

function! VlimeStart()
    call vlime#server#New(v:true, get(g:, "vlime_cl_use_terminal", v:false))
endfunction

function! VlimeQlotExec()
    call vlime#server#New(v:true, get(g:, "vlime_cl_use_terminal", v:false), v:null, "qlot")
endfunction
