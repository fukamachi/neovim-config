"colorscheme onehalfdark
autocmd ColorScheme * highlight Normal ctermfg=grey ctermbg=black
autocmd ColorScheme * highlight Comment ctermfg=33
let g:airline_powerline_fonts = 0

"カッコを薄くする
autocmd VimEnter,BufRead,BufNewFile * syntax match parens /[()]/ | highlight parens ctermfg=gray
highlight MatchParen cterm=underline ctermfg=75 ctermbg=none gui=underline guifg=#61afef guibg=none
