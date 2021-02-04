let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
            \ 'auto_complete_delay': 200,
            \ })

"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
