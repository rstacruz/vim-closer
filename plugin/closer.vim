augroup closer
  au!
  autocmd FileType *
    \ let b:closer_no_semi = 0 |
    \ let b:closer_no_semi_ctx = 0 |
    \ let b:closer_no_semi_ctx_neg = 0

  au FileType javascript
    \ let b:closer_flags = '([{;' |
    \ let b:closer_no_semi = '^\s*(function|class)' |
    \ let b:closer_no_semi_ctx = 'class' |
    \ let b:closer_no_semi_ctx_neg = ')\s*{$'
  au FileType ruby
    \ let b:closer_flags = '([{'
  au FileType css,scss,less,stylus
    \ let b:closer_flags = '([{'
  au FileType c,cpp,xdefaults,objc
    \ let b:closer_flags = '([{'

  autocmd FileType * call closer#enable()
augroup END
