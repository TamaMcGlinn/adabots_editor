 function! AbeInsertDefaultContents(filename, template_filename) abort
  " read template
  execute 'r /abe_templates/' . a:template_filename
  " procedure name is filename minus extension
  let l:procedure_name = substitute(a:filename, '\..*$', '', '')
  " replace __FILENAME__ with procedure name
  execute '%s/__FILENAME__/'.l:procedure_name.'/g'
  " delete first line
  execute 'normal! ggdd'
  " jump to start marker
  call search('__START__')
  if g:abe_insert_only
    execute 'normal! C'
    call nvim_feedkeys(nvim_replace_termcodes('<Right>',v:true,v:false,v:true),'m',v:true)
  else
    execute 'normal! D'
  endif
endfunction

function! AbeNewFile() abort
  let l:new_file_options = [
        \['[New program]', 'call AbeNewProgram()'],
        \['[New package]', 'call AbeNewPackage()'],
    \]
  let l:opts = {}
  call quickui#listbox#open(l:new_file_options, l:opts)
endfunction

function! AbeNewProgram() abort
  let l:filename = GetFileName("example.adb", ".adb")
  let l:full_path = GetFullPath(l:filename)
  call AbeCreateFileFromTemplate(l:filename, l:full_path, "program.adb")
endfunction

function! AbeNewPackage() abort
  let l:filename = GetFileName("example_package.ads", ".ads")
  let l:body_file = substitute(l:filename, '.ads$', '.adb', '')
  let l:body_fullpath = GetFullPath(l:body_file)
  call AbeCreateFileFromTemplate(l:body_file, l:body_fullpath, "package.adb")
  execute "w"
  let l:full_path = GetFullPath(l:filename)
  call AbeCreateFileFromTemplate(l:filename, l:full_path, "package.ads")
endfunction

function! AbeCreateFileFromTemplate(filename, full_path, template_filename) abort
  let l:file_exists=!empty(glob(a:full_path))
  execute "e " . a:full_path
  " if it didn't already exist before, insert default contents and save
  if !l:file_exists
    call AbeInsertDefaultContents(a:filename, a:template_filename)
  endif
endfunction

function! GetFileName(default_filename, extension) abort
  let l:filename = ''
  while l:filename =~# '^ *$'
    let l:filename = quickui#input#open('Filename:', a:default_filename)
  endwhile
  let l:filename = substitute(l:filename, '^ *', '', '')
  let l:filename = substitute(l:filename, ' ', '_', 'g')
  if !(l:filename =~? '^[^\.]*\.ad[bs]$')
    " remove all extensions (if any)
    let l:filename = substitute(l:filename, '\..*$', '', '')
    " add .adb
    let l:filename = substitute(l:filename, '$', a:extension, '')
  endif
  return l:filename
endfunction

function! GetFullPath(source_file) abort
  return g:abe_root_dir . a:source_file
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
  " replace each item (which is just a file name) with
  " a list of: filename (shown in the UI), nvim instruction to open the file (needs full path)
  let l:contents = map(copy(files), '[v:val, "e /adabots_examples/src/" . v:val]')
  " Add a non-file entry to start a new program
  call insert(l:contents, ['  [New program]  ', 'call AbeNewProgram()'], len(l:contents))
  call insert(l:contents, ['  [New package]  ', 'call AbeNewPackage()'], len(l:contents))
  let l:opts = {}
  call quickui#listbox#open(l:contents, l:opts)
endfunction

function! AbeSave() abort
  if expand('%') =~? '\.ad[sb]$'
    execute "w"
  endif
endfunction

function! AbeQuit() abort
  if !(&buftype ==# 'nofile' || expand('%') ==# '')
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
