"colorscheme torte
" set number
set guioptions-=T
" set showtabline=2
" set ruler
set guifont=Source\ Code\ Pro\ Medium\ 11
set background=dark
colorscheme solarized
if &encoding ==# 'latin1' && has('gui_running')
	set encoding=utf-8
endif
set guioptions-=mlLrR "dont show menu or scrollbars
