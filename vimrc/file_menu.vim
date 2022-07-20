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
  let l:filename = quickui#input#open('Filename:', 'example.adb')
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
  execute "stopinsert"
  " execute "e " . g:abe_root_dir
  let l:files = systemlist("ls /adabots_examples/src/*.ad[sb]")
	call map(l:files, 'substitute(v:val, "/adabots_examples/src/", "", "")')
  let l:contents = map(copy(files), '[v:val, "e " . v:val]')
	call insert(l:contents, ['[New file]', 'call AbeNewFile()'], len(l:contents))
  let l:opts = {}
  call quickui#listbox#open(l:contents, l:opts)
endfunction

function! AbeSave() abort
  execute "w"
endfunction

function! AbeQuit() abort
  execute "wqall"
endfunction

call quickui#menu#install('&File', [
            \ [ "&New Program\tCtrl+n", 'call AbeNewFile()' ],
            \ [ "&Open\tCtrl+o", 'call AbeOpen()' ],
            \ [ "&Save\tCtrl+s", 'call AbeSave()'],
            \ [ "&Quit\tCtrl+q", 'call AbeQuit()' ],
            \ ])
