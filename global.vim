set nocompatible
syntax on
filetype plugin indent on

set noeol
set binary

" presentation settings
if v:version < 703
	set number
else
	set relativenumber

	function! NumberToggle()
		if(&relativenumber == 1)
			set number
		else
			set relativenumber
		endif
	endfunc

	nnoremap <C-n> :call NumberToggle()<cr>
endif
set numberwidth=3       " number of columns for line numbers
set textwidth=0         " Do not wrap words (insert)
set nowrap              " Do not wrap words (view)
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ruler               " line and column number of the cursor position
set wildmenu            " enhanced command completion
set visualbell          " use visual bell instead of beeping
set noerrorbells
set laststatus=2        " always show the status line
set listchars=tab:▷⋅,trail:·,eol:$
set list

set sessionoptions-=options " do not store global and local values in a session
set sessionoptions-=folds " do not store folds

let g:isDarwin = 0
if has("unix")
	let s:uname = system("uname")
	if s:uname == "Darwin\n"
		let g:isDarwin = 1
	endif
endif

" turn off blinking cursor in normal mode
set gcr=n:blinkon0

colorscheme jvcolorscheme

" set gfn=Inconsolata:h14
set gfn=Meslo\ LG\ S\ DZ:h13


" highlight spell errors
hi SpellErrors guibg=red guifg=black ctermbg=red ctermfg=black

set statusline=%(%l/%L\ %c%V\ %P%)\ %#warningmsg#%*%=%-h%m%r\ %t%*\ 

" behaviour

                        " ignore these files when completing names and in
                        " explorer
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif
set shell=/bin/bash     " use bash for shell commands
set noautowriteall      " Do not automatically save before commands like :next and :make
set hidden              " enable multiple modified buffers
set history=1000
set autoread            " automatically read file that has been changed on disk and doesn't have changes in vim
set backspace=indent,eol,start
set guioptions-=T       " disable toolbar"
set completeopt=menuone,preview
let bash_is_sh=1        " syntax shell files as bash scripts
set cinoptions=:0,(s,u0,U1,g0,t0 " some indentation options ':h cinoptions' for details
set modeline
set modelines=5         " number of lines to check for vim: directives at the start/end of file
"set fixdel                 " fix terminal code for delete (if delete is broken but backspace works)

set ts=4                " number of spaces in a tab
set sw=4                " number of spaces for indent
set noet                " do not expand tabs into spaces

:command! -range=% -nargs=0 T2S execute "<line1>,<line2>s/^\\t\\+/\\=substitute(submatch(0), '\\t', repeat(' ', ".&ts."), 'g')"
:command! -range=% -nargs=0 S2T execute "<line1>,<line2>s/^\\( \\{".&ts."\\}\\)\\+/\\=substitute(submatch(0), ' \\{".&ts."\\}', '\\t', 'g')"

set history=1000
set undolevels=1000
if v:version >= 703
	set undofile
endif
set scrolloff=3
set sidescroll=1
set sidescrolloff=15
set wildmode=longest:list,full
set smarttab
set ttyfast


" mouse settings
if has("mouse")
  set mouse-=a
endif
set mousehide                           " Hide mouse pointer on insert mode."


" search settings
set incsearch           " Incremental search
set hlsearch            " Highlight search match
set ignorecase          " Do case insensitive matching
set smartcase           " do not ignore if search pattern has CAPS


" directory settings
set backupdir=~/.backup//,.
if v:version >= 703
	set undodir=~/.backup//,.
endif
set directory=~/.backup//,~/tmp//,.


" folding
set foldcolumn=0        " columns for folding
set foldmethod=indent
set foldlevel=9
set nofoldenable        "dont fold by default "


"set clipboard=unnamed

set pastetoggle=<F2>
set tags=tags;/

let g:LustyJugglerShowKeys = 'a'

" extended '%' mapping for if/then/else/end etc
runtime macros/matchit.vim

let g:vimwiki_list = [{"path": "~/Dropbox/wiki/", "path_html": "~/Dropbox/wiki_html/"}]

let g:netrw_browse_split = 2
" use directory listing cache only remotely
let g:netrw_fastbrowse = 1
" default to tree listing style
let g:netrw_liststyle = 3
" remove default of putting directories first
let g:netrw_sort_sequence = "\<core\%(\.\d\+\)\=\>,\.h$,\.c$,\.cpp$,\~\=\*$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$"

let g:yankring_history_dir = "~/.vim/"

function! Textwrap()
	setlocal wrap
	setlocal linebreak
	setlocal nolist
	setlocal textwidth=0
	setlocal wrapmargin=0
endfunction

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
	let buffer_numbers = {}
	for quickfix_item in getqflist()
		let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
	endfor
	return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" set up some more useful digraphs
if has("digraphs")
    digraph ., 8230    " ellipsis (…)
endif


