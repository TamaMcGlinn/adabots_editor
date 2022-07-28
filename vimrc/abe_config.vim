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
  if g:abe_insert_only
    execute "startinsert"
  endif
endfunction

au BufEnter * call AbeBufEnter()

function! AbeNoArgStart() abort
  execute "enew"
  execute 'sleep 50m'
  call AbeOpen()
endfunction

command! AbeNoArgStart call AbeNoArgStart()

