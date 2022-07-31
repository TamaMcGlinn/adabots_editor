function! AbeVersionInfo() abort
  let l:version = substitute(readfile("/version")[1], '=', ' ', '')
  let l:version = tolower(substitute(l:version, '"', '', 'g'))
  let l:github_page = "https://www.github.com/TamaMcGlinn/AdaBots_editor"
  let l:textlist = ["AdaBots Editor (ABE)               [ESC] to close", l:version, l:github_page]
  call quickui#textbox#open(l:textlist, {})
endfunction

call quickui#menu#install('&Help', [
            \ [ "&Version info", 'call AbeVersionInfo()' ],
            \ ])
