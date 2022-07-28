function! AbeInsertDefaultProgram(filename) abort
  " read template
  execute 'r /abe_templates/program.adb'
  " replace __FILENAME__ with filename
  let l:procedure_name = substitute(a:filename, '\..*$', '', '')
  execute '%s/__FILENAME__/'.l:procedure_name.'/g'
  " delete first line
  execute 'normal! ggdd'
  " jump to end of line 6
  execute 'normal! 6gg$'
  if g:abe_insert_only
    execute "startinsert"
    call nvim_feedkeys(nvim_replace_termcodes('<Right>',v:true,v:false,v:true),'m',v:true)
  endif
  execute "w"
endfunction

function! AbeNewFile() abort
  let l:filename = ''
  while l:filename =~# '^ *$'
    let l:filename = quickui#input#open('Filename:', 'example.adb')
  endwhile
  let l:filename = substitute(l:filename, '^ *', '', '')
  let l:filename = substitute(l:filename, ' ', '_', 'g')
  if !(l:filename =~? '^[^\.]*\.ad[bs]$')
    " remove all extensions (if any)
    let l:filename = substitute(l:filename, '\..*$', '', '')
    " add .adb
    let l:filename = substitute(l:filename, '$', '.adb', '')
  endif
  let l:full_path = g:abe_root_dir . l:filename
  let l:file_exists=exists(l:full_path)
  execute "e " . l:full_path
  if !l:file_exists
    call AbeInsertDefaultProgram(l:filename)
    execute "w"
  endif
endfunction

function! AbeOpen() abort
  call AbeSave()
  " in case we are in beginner mode, we want insert mode off for the menu
  " execute "stopinsert"
  let l:files = systemlist("ls /adabots_examples/src/*.ad[sb] 2>/dev/null")
  if len(l:files) == 0
    call AbeNewFile()
    return
  endif
  " create menu with each .adb file
	call map(l:files, 'substitute(v:val, "/adabots_examples/src/", "", "")')
  let l:contents = map(copy(files), '[v:val, "e /adabots_examples/src/" . v:val]')
	call insert(l:contents, ['[New file]', 'call AbeNewFile()'], len(l:contents))
  let l:opts = {}
  call quickui#listbox#open(l:contents, l:opts)
endfunction

function! AbeSave() abort
  if expand('%') =~? '\.ad[sb]$'
    execute "w"
  endif
endfunction

function! AbeQuit() abort
  if !(expand('%') ==# '')
    execute "w"
  endif
  execute "qall!"
endfunction

call quickui#menu#install('&File', [
            \ [ "&New Program\tCtrl+n", 'call AbeNewFile()' ],
            \ [ "&Open\tCtrl+o", 'call AbeOpen()' ],
            \ [ "&Save\tCtrl+s", 'call AbeSave()'],
            \ [ "&Quit\tCtrl+q", 'call AbeQuit()' ],
            \ ])
