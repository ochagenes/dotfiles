let java_highlight_functions="style"
let java_highlight_java_lang_ids=1
setlocal makeprg=javac\ %
"set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
setlocal errorformat=%A%f:%l:%m,%-Z%p^,%-C%.%#
nnoremap <silent> <F3> :w<CR>:make<CR>:bo cw<CR>
setlocal foldmethod=marker
setlocal foldmarker={,}
source ~/.vim/macros/jcommenter.vim/plugin/jcommenter.vim
