
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
  inoremap <silent> <c-space> <c-o>:call quickui#menu#open()<cr>
  inoremap <silent> <c-n> <c-o>:call AbeNewFile()<cr>
  inoremap <silent> <c-o> <c-o>:call AbeOpen()<cr>
  inoremap <silent> <c-s> <c-o>:call AbeSave()<cr>
  inoremap <silent> <c-q> <c-o>:call AbeQuit()<cr>
  inoremap <silent> <c-b> <c-o>:call AbeCompile()<cr>
  inoremap <ESC> <NOP>
  inoremap <c-c> <NOP>
  inoremap <c-v> <NOP>
endfunction

function! AbeDisableInsertModeMappings() abort
  " only cntrl-space for menu is left in insert mode
  " iunmap <c-space>
  iunmap <c-n>
  iunmap <c-s>
  iunmap <c-q>
  iunmap <c-b>
  iunmap <ESC>
  iunmap <c-c>
  iunmap <c-v>
endfunction

call AbeEnableInsertModeMappings()
