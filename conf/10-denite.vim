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
