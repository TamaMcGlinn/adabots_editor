
function! AbeNewFile() abort
  let l:filename = input('Filename:', 'example.adb')
  execute "e /adabots_examples/src/" . l:filename
  " ensure insert mode
  execute "startinsert"
  " TODO check file empty (else return)
  call nvim_feedkeys(nvim_replace_termcodes('program<tab><cr>',v:true,v:false,v:true),'m',v:true)
  if !g:abe_insert_only
    execute "stopinsert"
  endif
endfunction

function! AbeQuit() abort
  execute "wqall"
endfunction

call quickui#menu#install('&File', [
            \ [ "&New Program\tCtrl+n", 'call AbeNewFile()' ],
            \ [ "&Save\tCtrl+s", 'w'],
            \ [ "&Quit\tCtrl+q", 'call AbeQuit()' ],
            \ ])

