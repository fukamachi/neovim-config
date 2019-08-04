nmap <C-M-q> =%

nmap <D-l> :call PareditMoveRight()<CR>mp=%`p
nmap <D-h> :call PareditMoveLeft()<CR>mp=%`p
nmap <D-s> :call PareditSplice()<CR>
nmap <M-l> :call PareditMoveRight()<CR>mp=%`p
nmap <M-h> :call PareditMoveLeft()<CR>mp=%`p
nmap <M-s> :call PareditSplice()<CR>
imap <M-l> <Esc>:call PareditMoveRight()<CR>

let g:vlime_cl_use_terminal = v:true

let g:vlime_cl_impl = "ros"
function! VlimeBuildServerCommandFor_ros(vlime_loader, vlime_eval)
    return ["rlwrap", "ros", "run",
               \ "--load", "~/.vim/dein/repos/github.com/l04m33/vlime/lisp/load-vlime.lisp",
               \ "--eval", a:vlime_eval]
endfunction

nmap <silent> <C-g> :call vlime#plugin#CloseWindow("repl")<CR>
nmap <silent> <M-.> :call vlime#plugin#FindDefinition(vlime#ui#CurAtom())<CR>
nmap <silent> <C-c><C-c> :call vlime#plugin#SendToREPL(vlime#ui#CurTopExpr())<CR>

"vlime-input-bufferで補完とインデントを有効に
augroup CustomVlimeInputBuffer
    autocmd!
    autocmd FileType vlime_input inoremap <silent> <buffer> <tab> <c-r>=vlime#plugin#VlimeKey("tab")<cr>
    autocmd FileType vlime_input setlocal omnifunc=vlime#plugin#CompleteFunc
    autocmd FileType vlime_input setlocal indentexpr=vlime#plugin#CalcCurIndent()
augroup end

let g:vlime_indent_keywords = {"if": 3, "define-package": 1}
