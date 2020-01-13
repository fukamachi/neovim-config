"TODO https://github.com/rhysd/reply.vim would be nice instead of iron repl
autocmd FileType python call s:python_my_mappings()
function! s:python_my_mappings() abort
  nnoremap <LocalLeader>s <Plug>(iron-send-motion)
  vnoremap <LocalLeader>s <Plug>(iron-visual-send)
  nnoremap <LocalLeader>rr :IronRepl<CR><Esc>
endfunction

let b:ale_linters = ['flake8']
