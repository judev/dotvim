
set nocompatible
syntax on
filetype plugin indent on

let g:isDarwin = 0
if has("unix")
	let s:uname = system("uname")
	if s:uname == "Darwin\n"
		let g:isDarwin = 1
	endif
endif

let g:vim_dir = expand('<sfile>:p:h')

set ttyfast

set noeol
set binary

set hidden
set noautowriteall
set autoread

set modeline
set modelines=5

set backspace=indent,eol,start

set smarttab
set shiftround
set tabstop=4
set shiftwidth=4
set noexpandtab
set textwidth=0
set nowrap

set listchars=tab:▷⋅,trail:·,eol:$
set list

set showmatch           " Show matching brackets.

set numberwidth=3       " number of columns for line numbers

if v:version >= 703
	set nonumber
	set relativenumber

	function! NumberToggle()
		if(&relativenumber == 1)
			set number
			set norelativenumber
		else
			set nonumber
			set relativenumber
		endif
	endfunc

	nnoremap <C-n> :call NumberToggle()<cr>
else
	set number
endif

set scrolloff=3
set sidescroll=1
set sidescrolloff=15

set ruler               " line and column number of the cursor position
set showcmd             " Show (partial) command in status line.
set laststatus=2        " always show the status line
set visualbell          " use visual bell instead of beeping
set noerrorbells

set incsearch           " Incremental search
set hlsearch            " Highlight search match
set ignorecase          " Do case insensitive matching
set smartcase           " do not ignore if search pattern has CAPS

set history=1000
set undolevels=1000
if v:version >= 703
	set undofile
endif

set backupdir=~/.backup//,.
if v:version >= 703
	set undodir=~/.backup//,.
endif
set directory=~/.backup//,~/tmp//,.


set foldcolumn=0        " columns for folding
set foldmethod=indent
set foldlevel=9
set nofoldenable        "dont fold by default "

set completeopt=menu,preview

set wildmenu
set wildmode=longest:list,full
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif

set shell=/bin/bash
let bash_is_sh=1

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

set sessionoptions-=options " do not store global and local values in a session
set sessionoptions-=folds " do not store folds

" turn off blinking cursor in normal mode
set gcr=n:blinkon0

" Returns statusline text for paste mode
function! StatusLinePaste()
	if &paste
		return ' [paste]'
	endif
	return ''
endfunction

" Returns statusline text for clipboard=unnamed
function! StatusLineUnnamed()
	if &clipboard == 'unnamed'
		return ' [clipboard]'
	endif
	return ''
endfunction

" Shows position of current buffer in arg list
function! BuildStatusLineArglistIndicator()
    return '%{argc()>1?(" [".repeat("-",argidx()).(expand("%")==argv(argidx())?"+":"~").repeat("-",argc()-argidx()-1)."]"):""}'
endfunction

function! BuildStatusLine()
	let l:s = ''
	let l:s .= '%(%l/%L %c%V %P%)'
	let l:s .= BuildStatusLineArglistIndicator()
	let l:s .= '%{StatusLinePaste()}%{StatusLineUnnamed()} %#warningmsg#%*%=%-h %m%r %t%* '
	return l:s
endfunction

set statusline=%!BuildStatusLine()


" GUI settings
set guioptions-=T       " disable toolbar
if has("mouse")
  set mouse-=a
endif
set mousehide


augroup vimrcEx
	" clear all autocmds in the group
	autocmd!

	" jump to last position in file when opening
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

augroup END


" extended '%' mapping for if/then/else/end etc
runtime macros/matchit.vim


" set up some more useful digraphs
if has("digraphs")
    digraph ., 8230    " ellipsis (…)
endif

