
" Map space to leader
map <space> <leader>

" make j and k work as expected over wrapped lines
nnoremap j gj
nnoremap k gk

"make Y consistent with C and D
"nnoremap Y y$

" use <leader>y to yank to system clipboard
map <leader>y "*y
map <leader>Y "*Y

" use <leader>d to delete without clobbering previous yank/delete
map <leader>d "_d
map <leader>D "_D
" likewise <leader>c
map <leader>c "_c
map <leader>C "_C

nnoremap / ms/
nnoremap ? ms?

cnoremap §t <cr>:t's<cr>
cnoremap §m <cr>:m's<cr>
cnoremap §d <cr>:d<cr>'s

nnoremap <silent> <f1> :call SophHelp()<cr>
nmap <silent> <f2> :call TogglePasteMode()<cr>
nmap <silent> <f3> :call ToggleUnnamedClipboard()<cr>
nmap <silent> <f4> :call CTags()<cr>
nnoremap <f5> :GundoToggle<cr>
let g:script_runner_key = '<F6>'

" tab navigation with [Tab and ]Tab
nnoremap <silent> [<Tab> gT
nnoremap <silent> ]<Tab> gt

" swap parameters with [, and ],
nmap ], <Plug>ForwardSwapParams
nmap [, <Plug>BackwardSwapParams

" toggle highlight trailing whitespace
nmap <silent> <leader>s :set nolist!<CR>

" <cr> to disable search match highlight
nmap <silent> <cr> :nohlsearch<CR>
" map <cr> back to normal in quickfix buffers
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" map <cr> back to normal in command-line window
autocmd CmdwinEnter [:>] nnoremap <buffer> <CR> <CR>

" turn off search highlighting in insert mode
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch

" remap redraw from C-l as we're going to override it below
nmap <leader><C-l> :redraw<CR>

" Easy window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Switch and maximise windows
nmap <leader>h <C-w>h<C-w>\|
nmap <leader>j <C-w>j<C-w>_
nmap <leader>k <C-w>k<C-w>_
nmap <leader>l <C-w>l<C-w>\|

" split window
nmap <leader>wh        :leftabove  vsplit<CR>
nmap <leader>wl        :rightbelow vsplit<CR>
nmap <leader>wk        :leftabove  split<CR>
nmap <leader>wj        :rightbelow split<CR>

" w!! to write as root
cmap w!! w !sudo tee % >/dev/null

" <leader>cd to change working directory to current file directory
nmap <silent> <leader>cd :cd %:p:h<CR>

" make paste reformat and indent if preceded by Esc
nnoremap <Esc>P P'[v']=
nnoremap <Esc>p p'[v']=

" disable middle click to paste on mac
if exists("g:isDarwin") && g:isDarwin
	nnoremap <MiddleMouse> <Nop>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" command mode shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remap normal c-a to c-x (expands filename wildcards)
cnoremap <C-x> <C-a>
" readline-inspired bindings now included by vim-rsi plugin


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" arg list management
" http://blog.tommcdo.com/2014/03/manage-small-groups-of-related-files.html
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make a window-local copy of args. The execute trick is so it always copies
" current rather than using the args vim was launched with
nnoremap <leader>al :execute "arglocal " . join(argv(), " ")<CR>
" Add current file to args
nnoremap <leader>aa :argadd % <Bar> next<CR>
" Start a new args list containing just the current file
nnoremap <leader>as :arglocal! %<CR>
" Remove the current file from the args list and move to next
nnoremap <leader>ad :<C-R>=argidx()+1<CR>argdelete<CR>:<C-R>=min([argc(), argidx() + 1])<CR>argument<CR>
" Return to the current file
nnoremap <leader>ac :argument<CR>

" Map F1 to Esc in insert mode
imap <F1> <Esc>

" make ctrl-l in insert mode insert hash rocket
imap <c-l> <space>=><space>


