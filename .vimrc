set nocompatible              " be iMproved, required
filetype off                  " required

" ther ===----------------------
"
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
""""""""""""""""
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'gilligan/vim-lldb'
"Plugin 'simeji/winresizer'
"Plugin 'sheerun/vim-polyglot'

"_____________________Code/project navigation_________________
"Plugin 'scrooloose/nerdtree'                   " Project and file navigation
Plugin 'majutsushi/tagbar'                      " Class/module browser

"------------------=== Other ===----------------------
Plugin 'bling/vim-airline'                      " Lean & mean status/tabline for vim
Plugin 'fisadev/FixedTaskList.vim'              " Pending tasks list
Plugin 'rosenfeld/conque-term'                  " Consoles as buffers
Plugin 'tpope/vim-surround'                     " Parentheses, brackets, quotes, XML tags, and more

"--------------=== Snippets support ===---------------
Plugin 'garbas/vim-snipmate'                    " Snippets manager
Plugin 'MarcWeber/vim-addon-mw-utils'           " dependencies #1
Plugin 'tomtom/tlib_vim'                        " dependencies #2
Plugin 'honza/vim-snippets'                     " snippets repo

"---------------=== Languages support ===-------------
"" --- Python ---
Plugin 'klen/python-mode'                       " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
Plugin 'davidhalter/jedi-vim'                   " Jedi-vim autocomplete plugin
Plugin 'mitsuhiko/vim-jinja'                    " Jinja support for vim
Plugin 'mitsuhiko/vim-python-combined'          " Combined Python 2/3 for Vim

" All of your Plugins must be added before the following line
"""""""""""""
call vundle#end()            " required
filetype on
filetype plugin on
filetype plugin indent on    " required

"Включение автодополнения по TAB
function! SuperCleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction

inoremap <Tab> <C-R>=SuperCleverTab()<cr>


" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"_________________________________________________________________________________
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Jul 28
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set enc=utf-8
  set hlsearch
  set ic
  set incsearch
  set tabstop=4
  set shiftwidth=4
  set softtabstop=4
  set smarttab
  set noexpandtab
  set smartindent
  set et
"  set cursorline
  set showmatch
  set listchars=tab:··
  set list
"  set number
  set foldenable
  set foldmethod=syntax
  set mouse=a
  set ttymouse=xterm2
  tab sball
  set switchbuf=useopen
  "при переходе за границу в 80 символов в Ruby/Python/js/C/C++ подсвечиваем на темном фоне текст
  augroup vimrc_autocmds
          autocmd!
          autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
          autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/
          autocmd FileType ruby,python,javascript,c,cpp set nowrap
  augroup END
  " указываем каталог с настройками SnipMate
  let g:snippets_dir = "~/.vim/vim-snippets/snippets"
  
  " TagBar настройки
  map <F4> :TagbarToggle<CR>
  let g:tagbar_autofocus = 0 " автофокус на Tagbar при открытии

  " NerdTree настройки
  " показать NERDTree на F3
  map <F3> :NERDTreeToggle<CR>
  "игноррируемые файлы с расширениями
  let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']

  " TaskList настройки
  map <F2> :TaskList<CR>  " отобразить список тасков на F2
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif
syntax on
" Автовключение NERDTree и TagBar
autocmd vimenter * TagbarToggle
"autocmd vimenter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
colorscheme elflord
"colorscheme molokai

"=====================================================
"" Python-mode settings
"=====================================================
"" отключаем автокомплит по коду (у нас вместо него используется jedi-vim)
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" документация
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
" проверка кода
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore="E501,W601,C0110"
" провека кода после сохранения
let g:pymode_lint_write = 1

" поддержка virtualenv
let g:pymode_virtualenv = 1

" установка breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" подстветка синтаксиса
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" отключить autofold по коду
let g:pymode_folding = 0

" возможность запускать код
let g:pymode_run = 0

" Disable choose first function/method at autocomplete
let g:jedi#popup_select_first = 0


"=====================================================
" User hotkeys
"=====================================================

" ConqueTerm

" запуск интерпретатора на F5
"map <F5> !python3 %<CR>
map <F5> :w\|!python3 %<cr>
imap <F5> <Esc><F5>


" а debug-mode на <F6>
nnoremap <F6> :exe "ConqueTermSplit ipython " . expand("%")<CR>
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 0
" проверка кода в соответствии с PEP8 через <leader>8
autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>

" автокомплит через <Ctrl+Space>
inoremap <C-space> <C-x><C-o>
