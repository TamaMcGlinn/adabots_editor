
function! AbeToggleBackground() abort
  if &background == "dark"
    set background=light
  else
    set background=dark
  endif
endfunction

call quickui#menu#install("&Options", [
			\ ['%{g:abe_insert_only? "☑":"☐"} Beginner mode', 'call AbeToggleInsertOnly()'],
			\ ['%{g:ada_warnings_as_errors? "☑":"☐"} Warnings as errors', 'call ada_options#ToggleWarningsAsErrors()'],
			\ ['%{g:ada_autoformat? "☑":"☐"} Autoformatting', 'call ada_options#ToggleAutoformatting()'],
			\ ['%{&cursorline? "☑":"☐"} Highlight cursor line', 'set cursorline!'],
			\ ['%{&background == "dark"? "☑ Dark / ☐ Light":"☐ Dark / ☑ Light"}', 'call AbeToggleBackground()'],
			\ ])
