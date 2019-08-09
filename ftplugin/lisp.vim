nmap <C-M-q> =%

inoremap <M-l> <Esc>:call <Plug>(sexp_capture_next_element)<CR>
nnoremap <silent> <C-g> :call vlime#plugin#CloseWindow("")<CR>
nnoremap <silent> <LocalLeader>sl :call vlime#plugin#LoadFile(expand("%:p"))<CR>
nnoremap <silent> <LocalLeader>vi :call vlime#plugin#InteractionMode()<CR>

"http://koturn.hatenablog.com/entry/2015/07/18/101510
function! s:input(...) abort
    new
    cnoremap <buffer> <Esc> __CANCELED__<CR>
    try
        let input = call('input', a:000)
        let input = input =~# '__CANCELED__$' ? 0 : input
    catch /^Vim:Interrupt$/
        let input = -1
    finally
        bwipeout!
        return input
    endtry
endfunction

function! VlimeStartImpl()
    call inputsave()
    let cl_impl = s:input('Implementation (' . g:vlime_cl_impl . '): ')
    call inputrestore()
    if cl_impl is ''
        let cl_impl = g:vlime_cl_impl
    endif
    if cl_impl isnot 0
        call vlime#server#New(v:true, get(g:, "vlime_cl_use_terminal", v:false), v:null, cl_impl)
    endif
endfunction
