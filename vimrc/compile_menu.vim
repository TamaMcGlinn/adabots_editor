
function! AbeCompile() abort
  if &ft !=# "dirvish"
    execute "w"
    execute "!gprbuild -Xexecutables=%:t"
  endif
endfunction

call quickui#menu#install('&Compiler', [
            \ [ "&Compile\tCtrl+b", 'call AbeCompile()', 'Compile this file' ],
            \ ])

