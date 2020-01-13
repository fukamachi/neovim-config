function! SaveToDayOne()
    w !dayone2 new
endfunction
command! SaveToDayOne call SaveToDayOne()

function! Journal()
    let filename = strftime('~/Dropbox/Documents/Journal/%Y-%m-%d.md')
    execute ':edit ' . filename
    au FocusGained,BufEnter * :silent! !
endfunction
command! Journal call Journal()
nnoremap <silent> <M-j> :call Journal()<CR>
