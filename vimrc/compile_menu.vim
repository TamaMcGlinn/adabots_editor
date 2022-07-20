
function! AbeCompile() abort
  execute "w"
  execute "!gprbuild -Xexecutables=%:t"
endfunction

call quickui#menu#install('&Compiler', [
            \ [ "&Compile\tCtrl+b", 'call AbeCompile()', 'Compile this file' ],
            \ ])

