set shell=sh
"This was needed for python/black plugin, but 'brew install black' worked
"set pythonthreehome="/usr/local/opt/python@3.8/Frameworks/Python.framework/Versions/3.8"
"set pythonthreedll="/usr/local/opt/python@3.8/Frameworks/Python.framework/Versions/3.8/lib/libpython3.8.dylib"
"set pythonthreehome=/usr/local/opt/python@3.7/Frameworks/Python.framework/Versions/3.7/
"set pythonthreedll=/usr/local/opt/python@3.7/Frameworks/Python.framework/Versions/3.7/lib/libpython3.7m.dylib
"set pythonthreehome=/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/
"set pythonthreedll=/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/lib/libpython3.9.dylib

"Vundle
set nocompatible                    "Don't try to be compatible with vi
filetype off                        "Needed for vundle
set rtp+=~/.vim/bundle/Vundle.vim   "Add vundle to path
call vundle#begin()
    "vundle itself
Plugin 'VundleVim/Vundle.vim'
    "Project-wide searching
Bundle 'mileszs/ack.vim'
    "Folder navigator
Bundle 'scrooloose/nerdtree'
    "Tab completion
Bundle 'ervandew/supertab'
    "Open files by name
Bundle 'kien/ctrlp.vim'
    "CVS/SVN/SVK/git/hg/bzr integration plugin
Bundle 'vcscommand.vim'
    "syntax checker"
Bundle 'scrooloose/syntastic'
    "Dash documentation lookup"
Bundle 'rizzatti/dash.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
    "EJS highlighting"
"Bundle 'briancollins/vim-jst'
    "EditorConfig
Plugin 'editorconfig/editorconfig-vim'
    "Go Language Editing"
Plugin 'fatih/vim-go'
    "sh/bash linting"
Plugin 'itspriddle/vim-shellcheck'
    "Open in Marked 2
Plugin 'itspriddle/vim-marked'
    "Javascript support"
Plugin 'pangloss/vim-javascript'
    "Black Python formatting"
Plugin 'psf/black'
    "Rust syntax"
Plugin 'rust-lang/rust.vim'
    "UnicodeSearch, others"
Plugin 'chrisbra/unicode.vim'

call vundle#end()
filetype plugin indent on       "Loads filetype detection and all installed plugins


"File-specific handling
syntax on                   "Use sytax highlighting
set modeline                "Allow modelines in files to override settings
autocmd FileType python set omnifunc=pythoncomplete#Complete


"Indenting and tabs
set expandtab               "When inserting tabs, use spaces instead
set tabstop=4               "<Tab>=4 spaces
set shiftwidth=4            "Indenting=4 spaces
set autoindent              "Indent new lines like the current line
set copyindent              "copy the previous indentation on autoindenting
set smarttab                "insert tabs on the start of a line according to shiftwidth, not tabstop
set softtabstop=4           "Backspace into 4 spaces removes 4 spaces
set shiftround              "use multiple of shiftwidth when indenting with '<' and '>'
autocmd FileType make setlocal noexpandtab  "makefiles require real tabs

"JS indenting
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2

"Markdown
let g:vim_markdown_folding_disabled=1   "Disable folding
set nofoldenable

"au BufNewFile,BufRead *.ejs set filetype=html

"Search
set incsearch     "Search while typing
set hlsearch      "highlight search terms
set showmatch     "set show matching parenthesis
set smartcase     "ignore case if search pattern is all lowercase, case-sensitive otherwise
"set ignorecase    " ignore case when searching
autocmd BufRead,BufNewFile *.md setlocal spell


"Chrome
set ruler                   "Show current file position
set laststatus=2            "Always have status line on last window
set number                  "Show line numbers
set nowrap                  "don't wrap lines
"set backspace=indent,eol,start " allow backspacing over everything in insert mode
"set hidden                 "hide rather than close buffers
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep"

"Highlight whitespace
set list
set listchars=tab:>_,trail:_,extends:#,nbsp:_


"Mouse
set mouse=a                 "Enable mouse for all modes
set ttymouse=xterm2         "Use xterm2 protocol, reporting mouse position while dragging


"More like textmate
set autoread                "Detect and reload files changed on disk
set nobackup
set noswapfile
set tags=~/.ctags_cache
let NERDTreeIgnore=['\.o$', '\~$', '\.pyc']

"Syntastic
let g:syntastic_js_jslint_args = ""
let g:rustfmt_autosave = 1
"let g:syntastic_rst_checkers = ['sphinx']

"https://medium.com/@hpux/vim-and-eslint-16fa08cc580f
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'
let g:syntastic_python_checkers = ['flake8', 'mypy']
let g:syntastic_python_flake8_args = "--config=.flake8"

"Macro stuff
let mapleader="\\"
nmap <silent> <leader>ev :tabe $MYVIMRC<CR>
nmap <silent> <leader>sv :source $MYVIMRC<CR>
nmap <silent> <leader>N :NERDTree<CR>
nmap <silent> <leader>ipdb iimport ipdb; ipdb.set_trace()<CR><Esc>:w<CR>
nmap <silent> <leader>pdb iimport pdb; pdb.set_trace()<CR><Esc>:w<CR>
nmap <silent> <leader>xipdb :g/^\s*import ipdb; ipdb.set_trace()$/d<CR><Esc>:w<CR>
cmap w!! w !sudo tee > /dev/null %

"Disable arrow keys so I'll learn
function! NoArrows()
    noremap  <Up> ""
    noremap! <Up> <Esc>
    noremap  <Down> ""
    noremap! <Down> <Esc>
    noremap  <Left> ""
    noremap! <Left> <Esc>
    noremap  <Right> ""
    noremap! <Right> <Esc>
endfunction
"call NoArrows()

function! YesArrows()
    unmap  <Up>
    unmap! <Up>
    unmap  <Down>
    unmap! <Down>
    unmap  <Left>
    unmap! <Left>
    unmap  <Right>
    unmap! <Right>
endfunction

"https://github.com/macvim-dev/macvim/wiki/Python-2.x-and-Python-3.x
function! s:py3_test()
    py3 import time
    py3 from ctypes import *
    py3 lib = cdll.LoadLibrary("/usr/lib/libc.dylib")
    py3 print(time.ctime(lib.time(0)))
endfunction
function! s:py_test()
    py import time
    py from ctypes import *
    py lib = cdll.LoadLibrary("/usr/lib/libc.dylib")
    py print(time.ctime(lib.time(0)))
endfunction
"call s:py3_test()
"call s:py_test()

"vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='goplsv'
