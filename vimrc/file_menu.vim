
function! AbeNewFile() abort
  let l:filename = quickui#input#open('Filename:', 'example.adb')
  let l:full_path = g:abe_root_dir . l:filename
  let l:file_exists=exists(l:full_path)
  execute "e " . l:full_path
  if !l:file_exists
    " ensure insert mode
    execute "startinsert"
    call nvim_feedkeys(nvim_replace_termcodes('program<tab><cr>',v:true,v:false,v:true),'m',v:true)
    if !g:abe_insert_only
      execute "stopinsert"
    endif
    execute "w"
  endif
endfunction

function! AbeOpen() abort
  call AbeSave()
  execute "stopinsert"
  execute "e " . g:abe_root_dir
endfunction

function! AbeSave() abort
  if &ft !=# "dirvish"
    execute "w"
  endif
endfunction

function! AbeQuit() abort
  execute "wqall"
endfunction

call quickui#menu#install('&File', [
            \ [ "&New Program\tCtrl+n", 'call AbeNewFile()' ],
            \ [ "&Open\tCtrl+o", 'call AbeOpen()' ],
            \ [ "&Save\tCtrl+s", 'call AbeSave()'],
            \ [ "&Quit\tCtrl+q", 'call AbeQuit()' ],
            \ ])
