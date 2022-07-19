
function! AbeToggleBackground() abort
  if &background == "dark"
    set background=light
  else
    set background=dark
  endif
endfunction

call quickui#menu#install("&Options", [
			\ ['%{g:abe_insert_only? "[X]":"[ ]"} Insert mode only', 'call AbeToggleInsertOnly()'],
			\ ['%{&cursorline? "[X]":"[ ]"} Highlight cursor line', 'set cursorline!'],
			\ ['%{&background == "dark"? "[X] Dark / [ ] Light":"[ ] Dark / [X] Light"}', 'call AbeToggleBackground()'],
			\ ])
