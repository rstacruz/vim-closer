" if exists("g:closer_autoloaded") | finish | endif
" let g:closer_autoloaded=1

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
function! closer#close()
  " supress if it broke off a line (pressed enter not at the end)
  if match(getline('.'), '^\s*$') == -1 | return '' | endif

  let ln = line('.') - 1
  let line = getline(ln)

  let closetag = s:get_closing(line)
  if closetag == '' | return "" | endif

  let closetag = closetag . s:use_semicolon(ln)

  return "" . closetag . "\<C-O>O"
endfunction

" Returns the context of the function
" simply returns whatever's on the previous level of indentation
function! s:get_context()
  let ln = line('.') - 1
  let indent = strlen(matchstr(getline(ln), '^\s*'))
  while ln > 0
    let ln = prevnonblank(ln-1)
    let lntext = getline(ln)
    let nindent = strlen(matchstr(lntext, '^\s*'))
    if nindent < indent | return lntext | endif
  endwhile
  return 0
endfunction

" Checks if a semicolon is needed for a given line number
function! s:use_semicolon(ln)
  if ! exists('b:closer') | return '' | endif
  if match(b:closer_flags, ';') == -1 | return '' | endif

  " was semicolons ever used anywhere?
  " also, hard-coded assumption that 'use strict' should be ignored, since it
  " always requires a semicolon
  let used_semi = search(';$', 'wn') > 0
  if used_semi > 0 && used_semi == search('"use strict";$','wn') | return '' | endif
  if used_semi == "0" | return '' | endif

  " Account for ignore tags
  let line = getline(a:ln)
  if b:closer_no_semi != '0' && match(line, b:closer_no_semi) > -1
    return ''
  endif

  " for javascript ('f'), don't semicolonize if we're inside a class or obj
  " literal
  let ctx = s:get_context()
  if ctx != '0'
    if match(ctx, ')\s*{$') == -1 | return '' | endif
    if b:closer_no_semi_ctx_neg != '0' && match(ctx, b:closer_no_semi_ctx_neg) == -1 | return '' | endif
    if b:closer_no_semi_ctx != '0' && match(ctx, b:closer_no_semi_ctx) > -1 | return '' | endif
  endif

  return ';'
endfunction

" Returns the closing tag for a given line
"
"     get_closing('describe(function() {')
"     => '});'
"
"     get_closing('function x() {')
"     => '}'
"
function! s:get_closing(line)
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
