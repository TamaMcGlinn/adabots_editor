let g:abe_insert_only = v:true
let g:abe_root_dir = "/adabots_examples/src/"

source /vimrc/visuals.vim

" QuickUI menu
source /vimrc/file_menu.vim
source /vimrc/compile_menu.vim
source /vimrc/options_menu.vim
source /vimrc/normal_mappings.vim
source /vimrc/copy_paste.vim

" enable to display tips in the cmdline
let g:quickui_show_tip = 1

" cntrl-space to open menu
nnoremap <c-space> :call quickui#menu#open()<cr>

source /vimrc/abe_insert_only.vim

function! AbeBufEnter() abort
  if &ft ==# "dirvish"
    execute "enew"
    call AbeOpen()
    return
  endif
  execute "w"
  if g:abe_insert_only
    execute "startinsert"
  endif
endfunction

au BufReadPost * call AbeBufEnter()

function! AbeNoArgStart() abort
  execute "enew"
  call AbeOpen()
  execute 'sleep 250m'
  if !(expand('%') =~? '\.ad[sb]$')
    " if we are not looking at an Ada source file,
    " we must be looking at a menu, and it might not be visible
    " due to some glitch. So we do j to refresh the screen
    " if we do this for all cases, we end up actually inserting j
    call nvim_feedkeys('j','m',v:true)
  endif
endfunction

command! AbeNoArgStart call AbeNoArgStart()

