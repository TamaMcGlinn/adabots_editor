
function! AbeToggleBackground() abort
  if &background == "dark"
    set background=light
  else
    set background=dark
  endif
endfunction

call quickui#menu#install("&Options", [
			\ ['%{g:abe_insert_only? "☑":"☐"} Beginner mode', 'call AbeToggleInsertOnly()'],
			\ ['%{&cursorline? "☑":"☐"} Highlight cursor line', 'set cursorline!'],
			\ ['%{&background == "dark"? "☑ Dark / ☐ Light":"☐ Dark / ☑ Light"}', 'call AbeToggleBackground()'],
			\ ])
