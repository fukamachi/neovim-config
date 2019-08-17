map q: :q

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
