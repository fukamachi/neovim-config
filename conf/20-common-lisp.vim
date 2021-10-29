autocmd BufRead,BufNewFile *.asd set filetype=lisp
autocmd BufRead,BufNewFile *.ros set filetype=lisp
autocmd FileType lisp call s:common_lisp_my_mappings()
function! s:common_lisp_my_mappings() abort
  nnoremap <silent> <LocalLeader>rr :call VlimeStart()<CR>
  nnoremap <silent> <LocalLeader>rq :call VlimeQlotExec()<CR>
endfunction
call s:common_lisp_my_mappings()

let g:vlime_cl_impl = "mondo"
let g:vlime_cl_use_terminal = v:true
let s:vlime_path = '~/Programs/etc/vlime'

let g:vlime_window_settings = {
    \ 'server': {'pos': 'botright', 'size': v:null, 'vertical': v:true}
    \ }

let g:vlime_indent_keywords = {
  \ 'testing': 1,
  \ 'testing-app': 1,
  \ 'testing-api': 1,
  \ 'testing-partner': 1,
  \ 'testing-admin': 1,
  \ 'testing-worker': 1,
  \ 'testing-web': 1,
  \ }

function! VlimeBuildServerCommandFor_ros(vlime_loader, vlime_eval)
    return ["rlwrap", "ros", "run",
               \ "--load", s:vlime_path . "/lisp/load-vlime.lisp",
               \ "--eval", a:vlime_eval]
endfunction

function! VlimeBuildServerCommandFor_qlot(vlime_loader, vlime_eval)
    return ["rlwrap", "qlot", "exec", "ros", "run",
               \ "--load", s:vlime_path . "/lisp/load-vlime.lisp",
               \ "--eval", a:vlime_eval]
endfunction

function! VlimeBuildServerCommandFor_lem(vlime_loader, vlime_eval)
    return ["ros", "-L", "sbcl-bin", "-s", "lem-ncurses",
               \ "--load", s:vlime_path . "/lisp/load-vlime.lisp",
               \ "--eval", a:vlime_eval, "--eval", "(lem:lem)"]
endfunction

function! VlimeBuildServerCommandFor_sbcli(vlime_loader, vlime_eval)
    return ["ros", "-s", "sbcli",
               \ "--load", s:vlime_path . "/lisp/load-vlime.lisp",
               \ "--eval", a:vlime_eval, "--eval", "(sbcli/repl:main)"]
endfunction

function! VlimeBuildServerCommandFor_clrepl(vlime_loader, vlime_eval)
    return ["cl-repl",
                \ "--load", s:vlime_path . "/lisp/load-vlime.lisp",
                \ "--eval", a:vlime_eval]
endfunction

function! VlimeBuildServerCommandFor_mondo(vlime_loader, vlime_eval)
    return ["mondo", "--server", "vlime"]
endfunction

function! VlimeStart()
    call vlime#server#New(v:true, get(g:, "vlime_cl_use_terminal", v:false))
endfunction
command! VlimeStart call VlimeStart()
command! VlimeStartImpl call VlimeStartImpl()

function! VlimeQlotExec()
    call vlime#server#New(v:true, get(g:, "vlime_cl_use_terminal", v:false), v:null, "qlot")
endfunction
