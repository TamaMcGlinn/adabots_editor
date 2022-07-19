let g:abe_insert_only = v:true

source /vimrc/visuals.vim

" QuickUI menu
source /vimrc/file_menu.vim
source /vimrc/compile_menu.vim
source /vimrc/options_menu.vim

" enable to display tips in the cmdline
let g:quickui_show_tip = 1

" hit space twice to open menu
nnoremap <space><space> :call quickui#menu#open()<cr>

source /vimrc/abe_insert_only.vim

function! AbeBufEnter() abort
  if &buftype == ""
    execute "w"
    if g:abe_insert_only
      execute "startinsert"
    endif
  endif
endfunction

au BufEnter * call AbeBufEnter()
