" getting the docker image to share the system clipboard for ctrl-c ctrl-v 
" turns out to be a really hard problem
" the solution will involve either a file-based hack running xclip parallel to
" docker, or a user-defined bridge and networking

" set clipboard=
" vnoremap <C-c> "+y
" vnoremap <C-v> "+p
