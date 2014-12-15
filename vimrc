filetype off
call pathogen#infect('bundle/{}')
call pathogen#helptags()

"general stuff
set nocompatible
set bs=2 "Sane backspace
set shiftwidth=4 "Tabs to be 4 char wide
set tabstop=4 "Tabs to be 4 char wide
set noexpandtab "Tabs to be 4 char wide
set laststatus=2 "always show status bar
set noerrorbells "Keep co-workers happy
set number "show line numbers
let &showbreak = '+++> ' "Indicate linebreak
set scrolloff=4 "Show 4 lines above/below cursor
set sidescrolloff=5
set display+=lastline
set wildmenu "Completion menu
syntax on
filetype on
filetype plugin indent on

"change background color beyond 80 char
let &colorcolumn=join(range(81,500),",")

"colorscheme torte
"colorscheme molokai
set background=dark
colorscheme solarized

"statusline
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%{fugitive#statusline()}
set statusline+=%=      "left/right separator
set statusline+=%l,   "cursor line/total lines
set statusline+=%c%V     "cursor column
set statusline+=\ %P    "percent through file
"set statusline+=%-12.(%l,%c%V%)\ %<%P        " offset
"set statusline+=%{fugitive#statusline()}

hi StatusLine ctermfg=0 ctermbg=7 gui=bold,reverse
" now set it up to change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=7 gui=bold,reverse
endif

" indenting
set ai
set smartindent
set cindent

" don't redraw screen while exectuing macros
set lazyredraw

" folding (:help folding)
set foldenable
set foldmethod=indent
set foldlevelstart=99

" remap F1 to ": help "
nnoremap <F1> <ESC>:help 

" nice when using vim as email-editor
au FileType mail set textwidth=72 formatoptions=t

" avoid annoying "Hit ENTER to continue" prompts
"set shortmess=aTI
" Disable the splash screen ..oops
"set shortmess+=I

" incremental search
set incsearch

" hilight searches
set hlsearch

" turn off hihlighting with ^n
nmap <silent> <C-N> :silent noh<CR>

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
" (thanks Douglas Potts)
if has("unix")
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
endif

" Map F2 to :SidePanel
nnoremap <silent> <F2> :SidePanel<CR>
" Map F3 to :w, then :make
nnoremap <silent> <F3> :w<CR>:make clean<CR>:make<CR>
" Execute ./test
nnoremap <silent> <F4> :!./test<CR>
" Comment out lines with F5, PEP8 uses F5 
"nnoremap <silent> <F5> 0i/*<ESC>$a*/<ESC>
" Insert comments with F6
nnoremap <silent> <F6> A /*  */<esc>hhha
" \t is taken by CommantT
nnoremap <leader>v <Plug>TaskList

" Only display certain file-types in tagexplorer
" let TE_Include_File_Pattern = '.*\.c$\|.*\.h$\|.*\cc$\|.*\cpp$\|Makefile$\|.*\.py$\|.*\.asm$\|.*\.s$\|.*\.sh$\|.*\.pl$\|.*\.pas$'

let TE_Adjust_Winwidth = 0 


" Change to the directory the file in your current buffer is in
if has ("autocmd")
autocmd BufEnter * :cd %:p:h
endif " has("autocmd")

" use tab for tab-completion in insert mode
function InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
	return "\<tab>"
	else
	return "\<c-p>"
	endif
endfunction

"inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" move _and_ scroll down one line
nnoremap <C-J> 1<C-D>:set scroll=0<CR>
" move _and_ scroll up one line
nnoremap <C-K> 1<C-U>:set scroll=0<CR>

" Toggle fold state between closed and opened.
"
" If there is no fold at current line, just moves forward.
" If it is present, reverse it's state.
fun! ToggleFold()
	if foldlevel('.') == 0
	normal! l
	else
	if foldclosed('.') < 0
	. foldclose
	else
	. foldopen
	endif
	endif
	" Clear status line
	echo
endfun

noremap <space> :call ToggleFold()<CR>

" Don't loose folds :)
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

" go up/down to the next line when cursor hits rigt/left edge
" nnoremap <silent> h       :call WrapLeft()<cr>
" nnoremap <silent> l       :call WrapRight()<cr>

function! WrapLeft()
	let col = col(".")
	if 1 == col
	" don't wrap if we're on the first line
	if 1 == line(".")
	return
	endif
	normal! k$
	else
	normal! h
	endif
endfunction

function! WrapRight()
	let col = col(".")
	if 1 != col("$")
	let col = col + 1
	endif

	if col("$") == col
	" don't wrap if we're on the last line
	if line("$") == line(".")
	return
	endif
	normal! j1|
	else
	normal! l
	endif
endfunction

" use :Sp to open more than one file
function! Sp(...)
	if(a:0 == 0)
	sp
	else
	let i = a:0
	while(i > 0)
	execute 'let file = a:' . i
	execute 'sp ' . file

	let i = i - 1
	endwhile
	endif
endfunction
com! -nargs=* -complete=file Sp call Sp(<f-args>)
cab sp Sp

" Close paranthesis, braces and brackets automatically
" (escape from the evil paranthesis, braces and brackets afterwards with ^L)
" :inoremap ( ()<ESC>:let leavechar=")"<CR>i
" :inoremap { {}<ESC>:let leavechar="}"<CR>i
" :inoremap [ []<ESC>:let leavechar="]"<CR>i

:imap <C-l> <ESC>:exec "normal f" . leavechar<CR>a

set list
set lcs=tab:│\ ,trail:·,extends:>,precedes:<,nbsp:&
"set lcs=tab:└─,trail:·,extends:>,precedes:<,nbsp:&
"set lcs=tab:│┈,trail:·,extends:>,precedes:<,nbsp:&

"SidePanel config
let g:sidepanel_use_rabbit_ui = 0
let g:sidepanel_config = {}
let g:sidepanel_config['nerdtree'] = {}
let g:sidepanel_config['tagbar'] = {}
let g:sidepanel_config['gundo'] = {}

