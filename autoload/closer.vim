if exists("g:closer_autoloaded") | finish | endif
let g:closer_autoloaded=1

" Enables closer for the current buffer
function! closer#enable()
  if exists('b:closer_flags')
    let b:closer = 1
    inoremap <CR> <C-R>=closer#close()<CR>
  endif
endfunction

" Adds a closing bracket if needed
function closer#close()
  if ! s:is_at_eol() | return "\<Enter>" | endif

  let line = getline('.')
  let closetag = s:get_closing(line)
  if closetag == '' | return "\<Enter>" | endif

  if s:use_semicolon(line) == 1
    let closetag = closetag . ';'
  endif

  let tab = ''
  if match(b:closer_flags, 'i') != -1 | let tab = "\<Tab>" | endif

  return "\<CR>" . closetag . "\<C-O>O" . tab
endfunction

" Checks if a semicolon is needed for a given line
function s:use_semicolon(line)
  if ! b:closer | return 0 | endif
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

function s:is_at_eol()
  return col('.') >= strlen(getline('.'))
endfunction
