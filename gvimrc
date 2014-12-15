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
set guioptions-=m "dont show menu
set guioptions-=l "dont show scrollbars
set guioptions-=L "dont show scrollbars
set guioptions-=r "dont show scrollbars
set guioptions-=R "dont show scrollbars
set mousemodel=popup_setpos "menu on right-click
