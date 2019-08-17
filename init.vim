runtime! conf/*.vim

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
set noshowmode
set cursorline

set wildmenu
set wildmode=longest:full,full

"行末空白の削除
let g:better_whitespace_filetypes_blacklist = ['vlime_input', 'quickrun', 'diff', 'gitcommit', 'unite', 'qf', 'help']
let g:better_whitespace_enabled=1

"AutoSave
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

"Notes
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2

function! SaveToDayOne()
    w !dayone2 new
endfunction
command! SaveToDayOne call SaveToDayOne()

function! Journal()
    let filename = strftime('~/Dropbox/Documents/Journal/%Y-%m-%d.md')
    execute ':edit ' . filename
endfunction
command! Journal call Journal()
nnoremap <silent> <M-j> :call Journal()<CR>

"Edit init.vim
function! Config()
    edit ~/.config/nvim/init.vim
endfunction
command! Config call Config()
