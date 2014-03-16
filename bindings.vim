
" Map space to leader
map <space> <leader>

" Don't use Ex mode, use Q for formatting
map Q gq

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

cnoremap $t <cr>:t's<cr>
cnoremap $m <cr>:m's<cr>
cnoremap $d <cr>:d<cr>'s

nmap <silent> <f2> :call TogglePasteMode()<cr>
nmap <silent> <f3> :call ToggleUnnamedClipboard()<cr>
nmap <silent> <f4> :call CTags()<cr>

" Just like windo, but restore the current window when done.
function! WinDo(command)
  let currwin=winnr()
  execute 'windo ' . a:command
  execute currwin . 'wincmd w'
endfunction
command! -nargs=+ -complete=command Windo call WinDo(<q-args>)

" Just like Windo, but disable all autocommands for super fast processing.
command! -nargs=+ -complete=command Windofast noautocmd call WinDo(<q-args>)

" Just like bufdo, but restore the current buffer when done.
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
command! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)

function! TogglePasteMode()
	set paste!
	Windofast redrawstatus
endfunction

function! ToggleUnnamedClipboard()
	if &clipboard == 'unnamed'
		set clipboard=
	else
		set clipboard=unnamed
	endif
	Windofast redrawstatus
endfunction

" tab navigation with [Tab and ]Tab
nnoremap <silent> [<Tab> gT
nnoremap <silent> ]<Tab> gt

" swap parameters with [, and ],
nmap ], <Plug>ForwardSwapParams
nmap [, <Plug>BackwardSwapParams

" toggle highlight trailing whitespace
nmap <silent> <leader>s :set nolist!<CR>

" <leader>. to disable search match highlight
nmap <silent> <leader>. :nohlsearch<CR>

" <cr> to disable search match highlight
nmap <silent> <cr> :nohlsearch<CR>
" map <cr> back to normal in quickfix buffers
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" map <cr> back to normal in command-line window
autocmd CmdwinEnter [:>] nnoremap <buffer> <CR> <CR>

" turn off search highlighting in insert mode
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch

" make j and k work as expected over wrapped lines
nnoremap j gj
nnoremap k gk

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

" + and - to resize current window
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

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
nnoremap <leader>al :arglocal<CR>
nnoremap <leader>aa :argadd % <Bar> next<CR>
nnoremap <leader>as :arglocal! %<CR>
nnoremap <leader>ad :<C-R>=argidx()+1<CR>argdelete<CR>
nnoremap <leader>ac :argument<CR>


" Help for current word in normal mode
function! SophHelp()
  if &buftype=="help" && match( strpart( getline("."), col(".")-1,1), "\\S")<0
    bw
  else
    try
      exec "help ".expand("<cWORD>")
    catch /:E149:\|:E661:/
      " E149 no help for <subject>
      " E661 no <language> help for <subject>
      exec "help ".expand("<cword>")
    endtry
  endif
endfunc
nnoremap <silent> <F1> :call SophHelp()<CR>

" Map F1 to Esc in insert mode
imap <F1> <Esc>

" make ctrl-l in insert mode insert hash rocket
imap <c-l> <space>=><space>

