let g:quickrun_no_default_key_mappings = 1
if !has("g:quickrun_config")
	let g:quickrun_config = {}
endif
let g:quickrun_config._ = {
    \ 'runner': 'vimproc',
    \ 'outputter': 'buffer',
    \ 'outputter/buffer/running_mark': 'Running...',
    \ 'outputter/buffer/split' : 'botright 16sp',
	\ 'outputter/buffer/close_on_empty' : 1,
    \ 'outputter/buffer/into': 1,
\ }
autocmd! FileType quickrun setlocal nocursorline
"autocmd FileType quickrun AnsiEsc
nnoremap <silent> <C-x><C-x> :QuickRun -mode n<CR>

function! CloseMinorWindows()
    try
        bw! \[quickrun\ output\]
    catch
    endtry
endfunction
nnoremap <silent> <C-g> :call CloseMinorWindows()<CR>

let g:quickrun_config.lisp = {'exec' : "~/common-lisp/getac/roswell/getac.ros -F %s"}
