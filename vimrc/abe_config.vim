let g:quickui_border_style = 2

function! AbeNewFile() abort
  let l:filename = quickui#input#open('Filename:', 'example.adb')
  execute "e /adabots_examples/src/" .. l:filename
  " ensure insert mode
  execute "startinsert"
  " TODO check file empty (else return)
  call nvim_feedkeys(nvim_replace_termcodes('program<tab><cr>',v:true,v:false,v:true),'m',v:true)
  execute "w"
endfunction

inoremap <c-n> <c-o>:call AbeNewFile()<CR>
inoremap <c-s> <c-o>:write<CR>
inoremap <c-x> <c-o>:qall<CR>

call quickui#menu#install('&File', [
            \ [ "&New File\tCtrl+n", 'call AbeNewFile()' ],
            \ [ "&Save\tCtrl+s", 'w'],
            \ [ "E&xit\tCtrl+x", 'qall' ],
            \ ])

function! AbeCompile() abort
  execute "w"
  execute "!gprbuild -Xexecutables=%:t"
endfunction

inoremap <c-b> <c-o>:call AbeCompile()<CR>

" items containing tips, tips will display in the cmdline
call quickui#menu#install('&Compiler', [
            \ [ "&Compile\tCtrl+b", 'call AbeCompile()', 'Compile this file' ],
            \ ])

" register HELP menu with weight 10000
call quickui#menu#install('H&elp', [
			\ ["&Cheatsheet", 'help index', ''],
			\ ['T&ips', 'help tips', ''],
			\ ['--',''],
			\ ["&Tutorial", 'help tutor', ''],
			\ ['&Quick Reference', 'help quickref', ''],
			\ ['&Summary', 'help summary', ''],
			\ ], 10000)

" enable to display tips in the cmdline
let g:quickui_show_tip = 1

" hit space twice to open menu
nnoremap <space><space> :call quickui#menu#open()<cr>
inoremap <space><space> <c-o>:call quickui#menu#open()<cr>
