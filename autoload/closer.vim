if exists("g:closer_autoloaded") | finish | endif
let g:closer_autoloaded=1

if maparg("<Plug>CloserClose") == ""
  inoremap <silent> <SID>CloserClose <C-R>=closer#close()<CR>
  imap <script> <Plug>CloserClose <SID>CloserClose
endif

" Enables closer for the current buffer
function! closer#enable()
  if ! exists('b:closer_flags') | return | endif
  let b:closer = 1
  let oldmap = maparg('<CR>', 'i')

  if oldmap =~# 'CloserClose'
    " already mapped. maybe the user was playing with `set ft`
  elseif oldmap != ""
    exe "imap <CR> ".oldmap."<Plug>CloserClose"
  else
    imap  <CR> <CR><Plug>CloserClose
  endif
endfunction

" Adds a closing bracket if needed.
function closer#close()
  " supress if it broke off a line (pressed enter not at the end)
  if match(getline('.'), '^\s*$') == -1 | return '' | endif

  let ln = line('.') - 1
  let line = getline(ln)

  let closetag = s:get_closing(line)
  if closetag == '' | return "" | endif

  if s:use_semicolon(line) == 1
    let closetag = closetag . ';'
  endif

  let tab = ''
  if match(b:closer_flags, 'i') != -1 | let tab = "\<Tab>" | endif

  return "" . closetag . "\<C-O>O" . tab
endfunction

" Checks if a semicolon is needed for a given line
function s:use_semicolon(line)
  if ! exists('b:closer') | return 0 | endif
  if match(b:closer_flags, ';') == -1 | return 0 | endif

  " for javascript ('f'), don't semicolonize functions
  if match(b:closer_flags, 'f') >= 0 && match(a:line, '^\s*function') > -1
      return 0
  elseif match(b:closer_flags, 'c') >= 0 && match(a:line, '^\s*class') > -1
      return 0
  endif

  return 1
endfunction

" Returns the closing tag for a given line
"
"     get_closing('describe(function() {')
"     => '});'
"
"     get_closing('function x() {')
"     => '}'
"
function s:get_closing(line)
  let i = -1
  let clo = ''
  while 1
    let i = match(a:line, '[{}()\[\]]', i+1)
    if i == -1 | break | endif
    let ch = a:line[i]
    if ch == '{'
      let clo = '}' . clo
    elseif ch == '}'
      if clo[0] != '}' | return '' | endif
      let clo = clo[1:]
    elseif ch == '('
      let clo = clo . ')'
    elseif ch == ')'
      if clo[0] != ')' | return '' | endif
      let clo = clo[1:]
    elseif ch == '['
      let clo = clo . ']'
    elseif ch == ']'
      if clo[0] != ']' | return '' | endif
      let clo = clo[1:]
    endif
  endwhile
  return clo
endfunction
