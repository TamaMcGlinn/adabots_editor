
function! AbeToggleBackground() abort
  if &background == "dark"
    set background=light
  else
    set background=dark
  endif
endfunction

let g:abe_warnings_as_errors = v:true
function! AbeToggleWarningsAsErrors() abort
  let g:abe_warnings_as_errors = !g:abe_warnings_as_errors
  call setenv ("ADABOTS_WARNINGS_AS_ERRORS", g:abe_warnings_as_errors ? "enabled" : "disabled")
endfunction

call quickui#menu#install("&Options", [
			\ ['%{g:abe_insert_only? "☑":"☐"} Beginner mode', 'call AbeToggleInsertOnly()'],
			\ ['%{g:abe_warnings_as_errors? "☑":"☐"} Warnings as errors', 'call AbeToggleWarningsAsErrors()'],
			\ ['%{&cursorline? "☑":"☐"} Highlight cursor line', 'set cursorline!'],
			\ ['%{&background == "dark"? "☑ Dark / ☐ Light":"☐ Dark / ☑ Light"}', 'call AbeToggleBackground()'],
			\ ])
