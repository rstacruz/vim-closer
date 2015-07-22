augroup closer
  au!
  autocmd FileType *
    \ let b:closer = 0 |
    \ let b:closer_no_semi = 0 |
    \ let b:closer_semi_ctx = 0

  au FileType javascript
    \ let b:closer = 1 |
    \ let b:closer_flags = '([{;' |
    \ let b:closer_no_semi = '^\s*\(function\|class\|if\|else\)' |
    \ let b:closer_semi_ctx = ')\s*{$'
  au FileType ruby,go,c,cpp,xdefaults,objc,java,css,scss,less,stylus,puppet
    \ let b:closer = 1 |
    \ let b:closer_flags = '([{'

  autocmd FileType * call closer#enable()
augroup END
