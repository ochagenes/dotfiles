setlocal makeprg=rubber\ -fds\ %
setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
nnoremap <silent> <F3> :w<CR>:make<CR>:bo cw<CR>

