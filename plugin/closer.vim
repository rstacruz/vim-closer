augroup closer
  au!
  au FileType javascript let b:closer_flags = '([{;fc'
  au FileType ruby let b:closer_flags = '([{'
  au FileType css,scss,less,stylus let b:closer_flags = '([{'
  au FileType c,cpp,xdefaults,objc let b:closer_flags = '([{'
  autocmd FileType * call closer#enable()
augroup END
