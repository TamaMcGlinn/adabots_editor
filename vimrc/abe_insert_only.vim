
function! AbeToggleInsertOnly() abort
  let g:abe_insert_only = !g:abe_insert_only
  if g:abe_insert_only
    call AbeEnableInsertModeMappings()
    execute "startinsert"
  else
    call AbeDisableInsertModeMappings()
    execute "stopinsert"
  endif
endfunction

function! AbeEnableInsertModeMappings() abort
  inoremap <space><space> <c-o>:call quickui#menu#open()<cr>
  inoremap <c-n> <c-o>:call AbeNewFile()<CR>
  inoremap <c-s> <c-o>:write<CR>
  inoremap <c-q> <c-o>:call AbeQuit()<CR>
  inoremap <c-b> <c-o>:call AbeCompile()<CR>
  inoremap <ESC> <NOP>
endfunction

function! AbeDisableInsertModeMappings() abort
  " leave just the double-space menu defined
  " iunmap <space><space>
  iunmap <c-n>
  iunmap <c-s>
  iunmap <c-q>
  iunmap <c-b>
  iunmap <ESC>
endfunction

call AbeEnableInsertModeMappings()
