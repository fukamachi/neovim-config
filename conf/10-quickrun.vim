let g:quickrun_no_default_key_mappings = 1
if !has("g:quickrun_config")
	let g:quickrun_config = {}
endif
let g:quickrun_config._ = {
    \ 'runner': 'vimproc',
    \ 'outputter': 'buffer',
    \ 'outputter/buffer/running_mark': 'Running...',
    \ 'outputter/buffer/split' : 'botright 15sp',
	\ 'outputter/buffer/close_on_empty' : 1,
    \ 'outputter/buffer/into': 1,
\ }
autocmd FileType quickrun setlocal nocursorline
nnoremap <silent> <C-x><C-x> :QuickRun -mode n<CR>
