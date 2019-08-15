nmap <C-M-q> =-

nnoremap <silent> <C-g> :call vlime#plugin#CloseWindow("")<CR>
nnoremap <silent> <LocalLeader>sl :call vlime#plugin#LoadFile(expand("%:p"))<CR>
nnoremap <silent> <LocalLeader>vi :call vlime#plugin#InteractionMode()<CR>
inoremap <silent> <Return> <CR><C-o>:StripWhitespace<CR>

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

let g:vlime_default_mappings = {
            \ 'lisp': [
                \ ['n', '<LocalLeader>'.'?', ':call vlime#ui#ShowQuickRef("lisp")<cr>',
                    \ 'Show this quick reference.'],
                \
                \ ['i', '<space>', '<space><c-r>=vlime#plugin#VlimeKey("space")<cr>',
                    \ 'Trigger the arglist hint.'],
                \ ['i', '<cr>', '<cr><c-r>=vlime#plugin#VlimeKey("cr")<cr>',
                    \ 'Trigger the arglist hint.'],
                \ ['i', '<tab>', '<c-r>=vlime#plugin#VlimeKey("tab")<cr>',
                    \ 'Trigger omni-completion.'],
                \
                \ ['n', '<LocalLeader>'.'cc', ':call vlime#plugin#ConnectREPL()<cr>',
                    \ 'Connect to a server.'],
                \ ['n', '<LocalLeader>'.'cs', ':call vlime#plugin#SelectCurConnection()<cr>',
                    \ 'Switch connections.'],
                \ ['n', '<LocalLeader>'.'cd', ':call vlime#plugin#CloseCurConnection()<cr>',
                    \ 'Disconnect.'],
                \ ['n', '<LocalLeader>'.'cR', ':call vlime#plugin#RenameCurConnection()<cr>',
                    \ 'Rename the current connection.'],
                \
                \ ['n', '<LocalLeader>'.'rr', ':call vlime#server#New(v:true, get(g:, "vlime_cl_use_terminal", v:false))<cr>',
                    \ 'Run a new server and connect to it.'],
                \ ['n', '<LocalLeader>'.'rv', ':call vlime#plugin#ShowCurrentServer()<cr>',
                    \ 'View the console output of the current server.'],
                \ ['n', '<LocalLeader>'.'rV', ':call vlime#plugin#ShowSelectedServer()<cr>',
                    \ 'Show a list of Vlime servers and view the console output of the chosen one.'],
                \ ['n', '<LocalLeader>'.'rs', ':call vlime#plugin#StopCurrentServer()<cr>',
                    \ 'Stop the current server.'],
                \ ['n', '<LocalLeader>'.'rS', ':call vlime#plugin#StopSelectedServer()<cr>',
                    \ 'Show a list of Vlime servers and stop the chosen one.'],
                \ ['n', '<LocalLeader>'.'rR', ':call vlime#plugin#RenameSelectedServer()<cr>',
                    \ 'Rename a server.'],
                \ ['n', '<LocalLeader>'.'rc', ':call vlime#ui#repl#ClearREPLBuffer()<cr>',
                    \ 'Clear the REPL buffer.'],
                \
                \ ['n', '<LocalLeader>'.'ss', ':call vlime#plugin#SendToREPL(vlime#ui#CurExprOrAtom())<cr>',
                    \ 'Send the expression/atom under the cursor to the REPL.'],
                \ ['n', '<LocalLeader>'.'se', ':call vlime#plugin#SendToREPL(vlime#ui#CurExpr())<cr>',
                    \ 'Send the expression under the cursor to the REPL.'],
                \ ['n', '<LocalLeader>'.'st', ':call vlime#plugin#SendToREPL(vlime#ui#CurTopExpr())<cr>',
                    \ 'Send the top-level expression under the cursor to the REPL.'],
                \ ['n', '<LocalLeader>'.'sa', ':call vlime#plugin#SendToREPL(vlime#ui#CurAtom())<cr>',
                    \ 'Send the atom under the cursor to the REPL.'],
                \ ['n', '<LocalLeader>'.'si', ':call vlime#plugin#SendToREPL()<cr>',
                    \ 'Send a snippet to the REPL.'],
                \ ['v', '<LocalLeader>'.'s', ':<c-u>call vlime#plugin#SendToREPL(vlime#ui#CurSelection())<cr>',
                    \ 'Send the current selection to the REPL.'],
                \
                \ ['n', '<LocalLeader>'.'mm', ':call vlime#plugin#ExpandMacro(vlime#ui#CurExpr(), "expand")<cr>',
                    \ 'Expand the macro under the cursor.'],
                \ ['n', '<LocalLeader>'.'m1', ':call vlime#plugin#ExpandMacro(vlime#ui#CurExpr(), "one")<cr>',
                    \ 'Expand the macro under the cursor once.'],
                \ ['n', '<LocalLeader>'.'ma', ':call vlime#plugin#ExpandMacro(vlime#ui#CurExpr(), "all")<cr>',
                    \ 'Expand the macro under the cursor and all nested macros.'],
                \
                \ ['n', '<LocalLeader>'.'oe', ':call vlime#plugin#Compile(vlime#ui#CurExpr(v:true))<cr>',
                    \ 'Compile the expression under the cursor.'],
                \ ['n', '<LocalLeader>'.'ot', ':call vlime#plugin#Compile(vlime#ui#CurTopExpr(v:true))<cr>',
                    \ 'Compile the top-level expression under the cursor.'],
                \ ['n', '<LocalLeader>'.'of', ':call vlime#plugin#CompileFile(expand("%:p"))<cr>',
                    \ 'Compile the current file.'],
                \ ['v', '<LocalLeader>'.'o', ':<c-u>call vlime#plugin#Compile(vlime#ui#CurSelection(v:true))<cr>',
                    \ 'Compile the current selection.'],
                \
                \ ['n', '<LocalLeader>'.'xc', ':call vlime#plugin#XRefSymbol("CALLS", vlime#ui#CurAtom())<cr>',
                    \ 'Show callers of the function under the cursor.'],
                \ ['n', '<LocalLeader>'.'xC', ':call vlime#plugin#XRefSymbol("CALLS-WHO", vlime#ui#CurAtom())<cr>',
                    \ 'Show callees of the function under the cursor.'],
                \ ['n', '<LocalLeader>'.'xr', ':call vlime#plugin#XRefSymbol("REFERENCES", vlime#ui#CurAtom())<cr>',
                    \ 'Show references to the variable under the cursor.'],
                \ ['n', '<LocalLeader>'.'xb', ':call vlime#plugin#XRefSymbol("BINDS", vlime#ui#CurAtom())<cr>',
                    \ 'Show bindings for the variable under the cursor.'],
                \ ['n', '<LocalLeader>'.'xs', ':call vlime#plugin#XRefSymbol("SETS", vlime#ui#CurAtom())<cr>',
                    \ 'Show locations where the variable under the cursor is set.'],
                \ ['n', '<LocalLeader>'.'xe', ':call vlime#plugin#XRefSymbol("MACROEXPANDS", vlime#ui#CurAtom())<cr>',
                    \ 'Show locations where the macro under the cursor is called.'],
                \ ['n', '<LocalLeader>'.'xm', ':call vlime#plugin#XRefSymbol("SPECIALIZES", vlime#ui#CurAtom())<cr>',
                    \ 'Show specialized methods for the class under the cursor.'],
                \ ['n', '<LocalLeader>'.'xd', ':call vlime#plugin#FindDefinition(vlime#ui#CurAtom())<cr>',
                    \ 'Show the definition for the name under the cursor.'],
                \ ['n', '<LocalLeader>'.'xi', ':<c-u>call vlime#plugin#XRefSymbolWrapper()<cr>',
                    \ 'Interactively prompt for the symbol to search for cross references.'],
                \
                \ ['n', '<LocalLeader>'.'do', ':call vlime#plugin#DescribeSymbol(vlime#ui#CurOperator())<cr>',
                    \ 'Describe the operator of the expression under the cursor.'],
                \ ['n', '<LocalLeader>'.'da', ':call vlime#plugin#DescribeSymbol(vlime#ui#CurAtom())<cr>',
                    \ 'Describe the atom under the cursor.'],
                \ ['n', '<LocalLeader>'.'di', ':call vlime#plugin#DescribeSymbol()<cr>',
                    \ 'Prompt for the symbol to describe.'],
                \ ['n', '<LocalLeader>'.'ds', ':call vlime#plugin#AproposList()<cr>',
                    \ 'Apropos search.'],
                \ ['n', '<LocalLeader>'.'ddo', ':call vlime#plugin#DocumentationSymbol(vlime#ui#CurOperator())<cr>',
                    \ 'Show the documentation for the operator of the expression under the cursor.'],
                \ ['n', '<LocalLeader>'.'dda', ':call vlime#plugin#DocumentationSymbol(vlime#ui#CurAtom())<cr>',
                    \ 'Show the documentation for the atom under the cursor.'],
                \ ['n', '<LocalLeader>'.'ddi', ':call vlime#plugin#DocumentationSymbol()<cr>',
                    \ 'Prompt for a symbol, and show its documentation.'],
                \ ['n', '<LocalLeader>'.'dr', ':call vlime#plugin#ShowOperatorArgList(vlime#ui#CurOperator())<cr>',
                    \ 'Show the arglist for the expresison under the cursor.'],
                \
                \ ['n', ['<LocalLeader>'.'II', '<LocalLeader>'.'Ii'], ':call vlime#plugin#Inspect(vlime#ui#CurExprOrAtom())<cr>',
                    \ 'Evaluate the expression/atom under the cursor, and inspect the result.'],
                \ ['n', ['<LocalLeader>'.'IE', '<LocalLeader>'.'Ie'], ':call vlime#plugin#Inspect(vlime#ui#CurExpr())<cr>',
                    \ 'Evaluate the expression under the cursor, and inspect the result.'],
                \ ['n', ['<LocalLeader>'.'IT', '<LocalLeader>'.'It'], ':call vlime#plugin#Inspect(vlime#ui#CurTopExpr())<cr>',
                    \ 'Evaluate the top-level expression under the cursor, and inspect the result.'],
                \ ['n', ['<LocalLeader>'.'IA', '<LocalLeader>'.'Ia'], ':call vlime#plugin#Inspect(vlime#ui#CurAtom())<cr>',
                    \ 'Evaluate the atom under the cursor, and inspect the result.'],
                \ ['n', ['<LocalLeader>'.'IS', '<LocalLeader>'.'Is'], ':call vlime#plugin#Inspect(vlime#ui#CurSymbol())<cr>',
                    \ 'Inspect the symbol under the cursor.'],
                \ ['n', ['<LocalLeader>'.'IN', '<LocalLeader>'.'In'], ':call vlime#plugin#Inspect()<cr>',
                    \ 'Evaluate a snippet, and inspect the result.'],
                \ ['v', '<LocalLeader>'.'I', ':<c-u>call vlime#plugin#Inspect(vlime#ui#CurSelection())<cr>',
                    \ 'Evaluate the current selection, and inspect the result.'],
                \
                \ ['n', ['<LocalLeader>'.'TD', '<LocalLeader>'.'Td'], ':call vlime#plugin#OpenTraceDialog()<cr>',
                    \ 'Show the trace dialog.'],
                \ ['n', ['<LocalLeader>'.'TI', '<LocalLeader>'.'Ti'], ':call vlime#plugin#DialogToggleTrace()<cr>',
                    \ 'Prompt for a function name to trace/untrace.'],
                \ ['n', ['<LocalLeader>'.'TT', '<LocalLeader>'.'Tt'], ':call vlime#plugin#DialogToggleTrace(vlime#ui#CurAtom())<cr>',
                    \ 'Trace/untrace the function under the cursor.'],
                \
                \ ['n', '<LocalLeader>'.'uf', ':call vlime#plugin#UndefineFunction(vlime#ui#CurAtom())<cr>',
                    \ 'Undefine the function under the cursor.'],
                \ ['n', '<LocalLeader>'.'us', ':call vlime#plugin#UninternSymbol(vlime#ui#CurAtom())<cr>',
                    \ 'Unintern the symbol under the cursor.'],
                \ ['n', '<LocalLeader>'.'ui', ':<c-u>call vlime#plugin#UndefineUninternWrapper()<cr>',
                    \ 'Interactively prompt for the function/symbol to undefine/unintern.'],
                \
                \ ['n', '<LocalLeader>'.'i', ':call vlime#plugin#InteractionMode()<cr>',
                    \ 'Interaction mode.'],
                \ ['n', '<LocalLeader>'.'l', ':call vlime#plugin#LoadFile(expand("%:p"))<cr>',
                    \ 'Load the current file.'],
                \ ['n', '<LocalLeader>'.'a', ':call vlime#plugin#DisassembleForm(vlime#ui#CurExpr())<cr>',
                    \ 'Disassemble the form under the cursor.'],
                \ ['n', '<LocalLeader>'.'p', ':call vlime#plugin#SetPackage()<cr>',
                    \ 'Specify the package for the current buffer.'],
                \ ['n', '<LocalLeader>'.'b', ':call vlime#plugin#SetBreakpoint()<cr>',
                    \ 'Set a breakpoint at entry to a function.'],
                \ ['n', '<LocalLeader>'.'t', ':call vlime#plugin#ListThreads()<cr>',
                    \ 'Show a list of the running threads.'],
            \ ],
            \
            \ 'sldb': [
                \ ['n', '<LocalLeader>'.'?', ':call vlime#ui#ShowQuickRef("sldb")<cr>',
                    \ 'Show this quick reference.'],
                \
                \ ['n', '<cr>', ':call vlime#ui#sldb#ChooseCurRestart()<cr>',
                    \ 'Choose a restart.'],
                \ ['n', 'd', ':call vlime#ui#sldb#ShowFrameDetails()<cr>',
                    \ 'Show the details of the frame under the cursor.'],
                \ ['n', 'S', ':<c-u>call vlime#ui#sldb#OpenFrameSource()<cr>',
                    \ 'Open the source code for the frame under the cursor.'],
                \ ['n', 'T', ':<c-u>call vlime#ui#sldb#OpenFrameSource("tabedit")<cr>',
                    \ 'Open the source code for the frame under the cursor, in a separate tab.'],
                \ ['n', 'O', ':<c-u>call vlime#ui#sldb#FindSource()<cr>',
                    \ 'Open the source code for a local variable.'],
                \ ['n', 'r', ':call vlime#ui#sldb#RestartCurFrame()<cr>',
                    \ 'Restart the frame under the cursor.'],
                \ ['n', 's', ':call vlime#ui#sldb#StepCurOrLastFrame("step")<cr>',
                    \ 'Start stepping in the frame under the cursor.'],
                \ ['n', 'x', ':call vlime#ui#sldb#StepCurOrLastFrame("next")<cr>',
                    \ 'Step over the current function call.'],
                \ ['n', 'o', ':call vlime#ui#sldb#StepCurOrLastFrame("out")<cr>',
                    \ 'Step out of the current function.'],
                \ ['n', 'c', ':call b:vlime_conn.SLDBContinue()<cr>',
                    \ 'Invoke the restart labeled CONTINUE.'],
                \ ['n', 'a', ':call b:vlime_conn.SLDBAbort()<cr>',
                    \ 'Invoke the restart labeled ABORT.'],
                \ ['n', 'C', ':call vlime#ui#sldb#InspectCurCondition()<cr>',
                    \ 'Inspect the current condition object.'],
                \ ['n', 'i', ':call vlime#ui#sldb#InspectVarInCurFrame()<cr>',
                    \ 'Inspect a variable in the frame under the cursor.'],
                \ ['n', 'e', ':call vlime#ui#sldb#EvalStringInCurFrame()<cr>',
                    \ 'Evaluate an expression in the frame under the cursor.'],
                \ ['n', 'E', ':call vlime#ui#sldb#SendValueInCurFrameToREPL()<cr>',
                    \ 'Evaluate an expression in the frame under the cursor, and send the result to the REPL.'],
                \ ['n', 'D', ':call vlime#ui#sldb#DisassembleCurFrame()<cr>',
                    \ 'Disassemble the frame under the cursor.'],
                \ ['n', 'R', ':call vlime#ui#sldb#ReturnFromCurFrame()<cr>',
                    \ 'Return a manually specified result from the frame under the cursor.'],
            \ ],
            \
            \ 'repl': [
                \ ['n', '<LocalLeader>'.'?', ':call vlime#ui#ShowQuickRef("repl")<cr>',
                    \ 'Show this quick reference.'],
                \
                \ ['n', '<c-c>', ':call b:vlime_conn.Interrupt({"name": "REPL-THREAD", "package": "KEYWORD"})<cr>',
                    \ 'Interrupt the REPL thread.'],
                \ ['n', '<LocalLeader>'.'I', ':call vlime#ui#repl#InspectCurREPLPresentation()<cr>',
                    \ 'Inspect the evaluation result under the cursor.'],
                \ ['n', '<LocalLeader>'.'y', ':call vlime#ui#repl#YankCurREPLPresentation()<cr>',
                    \ 'Yank the evaluation result under the cursor.'],
                \ ['n', '<LocalLeader>'.'C', ':call vlime#ui#repl#ClearREPLBuffer()<cr>',
                    \ 'Clear the REPL buffer.'],
                \ ['n', ['<tab>', '<c-n>'], ':call vlime#ui#repl#NextField(v:true)<cr>',
                    \ 'Move the cursor to the next presented object.'],
                \ ['n', ['<s-tab>', '<c-p>'], ':call vlime#ui#repl#NextField(v:false)<cr>',
                    \ 'Move the cursor to the previous presented object.'],
            \ ],
            \
            \ 'mrepl': [
                \ ['n', '<LocalLeader>'.'?', ':call vlime#ui#ShowQuickRef("mrepl")<cr>',
                    \ 'Show this quick reference.'],
                \
                \ ['i', '<space>', '<space><c-r>=vlime#plugin#VlimeKey("space")<cr>',
                    \ 'Trigger the arglist hint.'],
                \ ['i', '<cr>', '<c-r>=vlime#ui#mrepl#Submit()<cr>',
                    \ 'Submit the last input to the REPL.'],
                \ ['i', '<c-j>', '<cr><c-r>=vlime#plugin#VlimeKey("cr")<cr>',
                    \ 'Insert a newline, and trigger the arglist hint.'],
                \ ['i', '<tab>', '<c-r>=vlime#plugin#VlimeKey("tab")<cr>',
                    \ 'Trigger omni-completion.'],
                \ ['i', '<c-c>', '<c-r>=vlime#ui#mrepl#Interrupt()<cr>',
                    \ 'Interrupt the MREPL thread.'],
                \ ['n', '<LocalLeader>'.'C', ':call vlime#ui#mrepl#Clear()<cr>',
                    \ 'Clear the MREPL buffer.'],
                \ ['n', '<LocalLeader>'.'D', ':call vlime#ui#mrepl#Disconnect()<cr>',
                    \ 'Disconnect from this REPL.'],
            \ ],
            \
            \ 'inspector': [
                \ ['n', '<LocalLeader>'.'?', ':call vlime#ui#ShowQuickRef("inspector")<cr>',
                    \ 'Show this quick reference.'],
                \
                \ ['n', ['<cr>', '<space>'], ':call vlime#ui#inspector#InspectorSelect()<cr>',
                    \ 'Activate the interactable field/button under the cursor.'],
                \ ['n', 's', ':call vlime#ui#inspector#SendCurValueToREPL()<cr>',
                    \ 'Send the value of the field under the cursor, to the REPL.'],
                \ ['n', 'S', ':call vlime#ui#inspector#SendCurInspecteeToREPL()<cr>',
                    \ 'Send the value being inspected to the REPL.'],
                \ ['n', 'o', ':<c-u>call vlime#ui#inspector#FindSource("part")<cr>',
                    \ 'Open the source code for the value of the field under the cursor.'],
                \ ['n', 'O', ':<c-u>call vlime#ui#inspector#FindSource("inspectee")<cr>',
                    \ 'Open the source code for the value being inspected.'],
                \ ['n', ['<tab>', '<c-n>'], ':call vlime#ui#inspector#NextField(v:true)<cr>',
                    \ 'Select the next interactable field/button.'],
                \ ['n', ['<s-tab>', '<c-p>'], ':call vlime#ui#inspector#NextField(v:false)<cr>',
                    \ 'Select the previous interactable field/button.'],
                \ ['n', 'p', ':call vlime#ui#inspector#InspectorPop()<cr>',
                    \ 'Return to the previous inspected object.'],
                \ ['n', 'P', ':call vlime#ui#inspector#InspectorNext()<cr>',
                    \ 'Move to the next inspected object.'],
                \ ['n', 'R', ':call b:vlime_conn.InspectorReinspect({c, r -> c.ui.OnInspect(c, r, v:null, v:null)})<cr>',
                    \ 'Refresh the inspector.'],
            \ ],
            \
            \ 'trace': [
                \ ['n', '<LocalLeader>'.'?', ':call vlime#ui#ShowQuickRef("trace")<cr>',
                    \ 'Show this quick reference.'],
                \
                \ ['n', ['<cr>', '<space>'], ':call vlime#ui#trace_dialog#Select()<cr>',
                    \ 'Activate the interactable field/button under the cursor.'],
                \ ['n', 'i', ':call vlime#ui#trace_dialog#Select("inspect")<cr>',
                    \ 'Inspect the value of the field under the cursor.'],
                \ ['n', 's', ':call vlime#ui#trace_dialog#Select("to_repl")<cr>',
                    \ 'Send the value of the field under the cursor to the REPL.'],
                \ ['n', 'R', ':call vlime#plugin#OpenTraceDialog()<cr>',
                    \ 'Refresh the trace dialog.'],
                \ ['n', ['<tab>', '<c-n>'], ':call vlime#ui#trace_dialog#NextField(v:true)<cr>',
                    \ 'Select the next interactable field/button.'],
                \ ['n', ['<s-tab>', '<c-p>'], ':call vlime#ui#trace_dialog#NextField(v:false)<cr>',
                    \ 'Select the previous interactable field/button.'],
            \ ],
            \
            \ 'xref': [
                \ ['n', '<LocalLeader>'.'?', ':call vlime#ui#ShowQuickRef("xref")<cr>',
                    \ 'Show this quick reference.'],
                \
                \ ['n', '<cr>', ':<c-u>call vlime#ui#xref#OpenCurXref()<cr>',
                    \ 'Open the selected source location.'],
                \ ['n', 't', ':<c-u>call vlime#ui#xref#OpenCurXref(v:true, "tabedit")<cr>',
                    \ 'Open the selected source location, in a separate tab.'],
                \ ['n', 's', ':<c-u>call vlime#ui#xref#OpenCurXref(v:true, "split")<cr>',
                    \ 'Open the selected source location, in a horizontal split window.'],
                \ ['n', 'S', ':<c-u>call vlime#ui#xref#OpenCurXref(v:true, "vsplit")<cr>',
                    \ 'Open the selected source location, in a vertical split window.'],
            \ ],
            \
            \ 'notes': [
                \ ['n', '<LocalLeader>'.'?', ':call vlime#ui#ShowQuickRef("notes")<cr>',
                    \ 'Show this quick reference.'],
                \
                \ ['n', '<cr>', ':<c-u>call vlime#ui#compiler_notes#OpenCurNote()<cr>',
                    \ 'Open the selected source location.'],
                \ ['n', 't', ':<c-u>call vlime#ui#compiler_notes#OpenCurNote("tabedit")<cr>',
                    \ 'Open the selected source location, in a separate tab.'],
                \ ['n', 's', ':<c-u>call vlime#ui#compiler_notes#OpenCurNote("split")<cr>',
                    \ 'Open the selected source location, in a horizontal split window.'],
                \ ['n', 'S', ':<c-u>call vlime#ui#compiler_notes#OpenCurNote("vsplit")<cr>',
                    \ 'Open the selected source location, in a vertical split window.'],
            \ ],
            \
            \ 'threads': [
                \ ['n', '<LocalLeader>'.'?', ':call vlime#ui#ShowQuickRef("threads")<cr>',
                    \ 'Show this quick reference.'],
                \
                \ ['n', '<c-c>', ':call vlime#ui#threads#InterruptCurThread()<cr>',
                    \ 'Interrupt the selected thread.'],
                \ ['n', 'K', ':call vlime#ui#threads#KillCurThread()<cr>',
                    \ 'Kill the selected thread.'],
                \ ['n', 'D', ':call vlime#ui#threads#DebugCurThread()<cr>',
                    \ 'Invoke the debugger in the selected thread.'],
                \ ['n', 'r', ':call vlime#ui#threads#Refresh()<cr>',
                    \ 'Refresh the thread list.'],
            \ ],
            \
            \ 'server': [
                \ ['n', '<LocalLeader>'.'?', ':call vlime#ui#ShowQuickRef("server")<cr>',
                    \ 'Show this quick reference.'],
                \
                \ ['n', '<LocalLeader>'.'c', ':call vlime#server#ConnectToCurServer()<cr>',
                    \ 'Connect to this server.'],
                \ ['n', '<LocalLeader>'.'s', ':call vlime#server#StopCurServer()<cr>',
                    \ 'Stop this server.'],
            \ ],
            \
            \ 'input': [
                \ ['n', '<LocalLeader>'.'?', ':call vlime#ui#ShowQuickRef("input")<cr>',
                    \ 'Show this quick reference.'],
                \
                \ ['n', ['<s-tab>', '<c-p>'], ':call vlime#ui#input#NextHistoryItem("backward")<cr>',
                    \ 'Show the previous item in input history.'],
                \ ['n', ['<tab>', '<c-n>'], ':call vlime#ui#input#NextHistoryItem("forward")<cr>',
                    \ 'Show the next item in input history.'],
            \ ],
        \ }
