augroup closer
  au!
  autocmd FileType *
    \ let b:closer = 0 |
    \ let b:closer_no_semi = 0 |
    \ let b:closer_semi_ctx = 0 |
    \ let b:closer_semi_check_top = 0

  au FileType javascript,javascript.jsx,javascriptreact,vue,typescript,typescriptreact
    \ let b:closer = 1 |
    \ let b:closer_flags = '([{;' |
    \ let b:closer_no_semi = '^\s*\(function\|class\|if\|else\)' |
    \ let b:closer_semi_ctx = ')\s*{$'

  au FileType c,cpp,css,elixir,go,java,javacc,json,less,lua,objc,puppet,python,ruby,rust,scss,sh,solidity,stylus,terraform,xdefaults,zsh
    \ let b:closer = 1 |
    \ let b:closer_flags = '([{'

  au FileType php
    \ let b:closer = 1 |
    \ let b:closer_flags = '([{;' |
    \ let b:closer_no_semi = '\s*\(function\s\+.\+(\|class\|if\|else\|for\|try\)' |
    \ let b:closer_semi_ctx = '\s*{$' |
    \ let b:closer_semi_check_top = 1

  autocmd FileType * call closer#enable()
augroup END
