" Map the leader key to SPACE
nnoremap <space> <Nop>
let mapleader="\<space>"

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'equalsraf/neovim-gui-shim'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'w0rp/ale'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline-themes'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
" Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'hecal3/vim-leader-guide'
Plug 'ehamberg/vim-cute-python'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'

" Initialize plugin system
call plug#end()

"general stuff
set encoding=utf-8
set nocompatible
set hidden
set backspace=indent,eol,start "Sane backspace
set shiftwidth=4 "Tabs to be 4 char wide
set tabstop=4 "Tabs to be 4 char wide
set noexpandtab "Indent using tab char
set laststatus=2 "always show status bar
set noerrorbells "Keep co-workers happy
set number "show line numbers
"let &showbreak = '+++> ' "Indicate linebreak
let &showbreak = '↪ '
set scrolloff=10 "Show 10 lines above/below cursor
set sidescrolloff=5
set showcmd " Visual feedback for commands
"set display+=lastline
set wildmenu "Completion menu
syntax on
"filetype on
filetype plugin indent on


"change background color beyond 80 char
" let &colorcolumn=join(range(81,81),",")
set colorcolumn=+1
"colorscheme solarized
set bg=dark

" indenting
set autoindent
set smartindent
set cindent

" folding (:help folding)
set foldenable
set foldmethod=indent
set foldlevelstart=99

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

" noremap <space> :call ToggleFold()<CR>

" incremental search
set incsearch

" hilight searches
set hlsearch

" turn off hihlighting with ^n
nmap <silent> <C-N> :silent noh<CR>

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

set list
set listchars=tab:│\ ,trail:·,extends:>,precedes:<,nbsp:&

" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" Enable Conceal
set conceallevel=2
" highlight Conceal guifg=LawnGreen guibg=Gray22

"=====
" Keys
"=====

" Shortcut to edit THIS configuration file: (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>

" Shortcut to source (reload) THIS configuration file after editing it: (s)ource (c)onfiguraiton
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>

" Airline tab shortcuts
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>bp <Plug>AirlineSelectPrevTab
nmap <leader>bn <Plug>AirlineSelectNextTab

" Toggle rainbow parentheses
nnoremap <leader>tp :RainbowToggle<CR>

" Toggle NerdTree
nnoremap <leader>tn :NERDTreeToggle<CR>

" Toggle tagbar
nnoremap <leader>tt :TagbarToggle<CR>
"=========
" Plugin config
"=========
" Airline setup
let g:airline_section_z = '%P'
let g:airline#extensions#whitespace#checks = [ 'trailing' ]
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#ctrlspace#enabled = 1

" Syntastic
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_warning_symbol = '⚠'
" let g:syntastic_auto_loc_list = 2
" let g:syntastic_enable_signs = 1

" Asynchronous Lint Engine
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Rainbow parentheses
let g:rainbow_active = 0 "0 if you want to enable it later via :RainbowToggle

" vimtex
let g:tex_flavor = 'latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_compiler_latexmk = {
    \ 'backend' : 'nvim',
    \ 'background' : 1,
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
\}
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

" IndentLine
" let g:indentLine_enabled = 1
" let g:indentLine_setColors = 1
" let g:indentLine_char = '▏'

" Leader-Guide
 let g:lmap =  {}
" call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

let g:llmap = {}
autocmd FileType tex let g:llmap.l = { 'name' : 'vimtex' }
call leaderGuide#register_prefix_descriptions("\\", "g:llmap")
nnoremap <localleader> :<c-u>LeaderGuide  "\\"<CR>
" vnoremap <localleader> :<c-u>LeaderGuideVisual  ','<CR>
" map <leader>. <Plug>leaderguide-global
" map <localleader>. <Plug>leaderguide-buffer

" CtrlSpace
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
let g:CtrlSpaceStatuslineFunction = "airline#extensions#ctrlspace#statusline()"
nnoremap <silent><C-Space> :CtrlSpace<CR>
