let mapleader = ","

" Don't use Ex mode, use Q for formatting
map Q gq

"make Y consistent with C and D
nnoremap Y y$

" toggle highlight trailing whitespace
nmap <silent> <leader>s :set nolist!<CR>

" ,. to disable search match highlight
nmap <silent> ,. :set hlsearch! hlsearch?<CR>
" Ctrl-N to disable search match highlight
nmap <silent> <C-N> :silent noh<CR>

" Ctrol-E to switch between 2 last buffers
nmap <C-E> :b#<CR>

" ,e to fast finding files. just type beginning of a name and hit TAB
nmap <leader>e :e **/

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" ,n to get the next location (compilation errors, grep etC)
nmap <leader>n :cn<CR>

"set completeopt=menuone,preview,longest
set completeopt=menuone,preview

" make j and k work as expected over wrapped lines
nnoremap j gj
nnoremap k gk

" Easy window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Easy window movement
nmap <leader><C-h> <C-w>H
nmap <leader><C-j> <C-w>J
nmap <leader><C-k> <C-w>K
nmap <leader><C-l> <C-w>L

" w!! to write as root
cmap w!! w !sudo tee % >/dev/null

" ,cd to change working directory to current file directory
nmap <silent> <Leader>cd :cd %:p:h<CR>

" make paste reformat and indent
nnoremap P P'[v']=
nnoremap p p'[v']=
"nnoremap <Esc>P P'[v']=
"nnoremap <Esc>p p'[v']=

" disable middle click to paste on mac
if g:isDarwin
	nnoremap <MiddleMouse> <Nop>
endif

nmap ,o :Utl<cr>

nmap <buffer><Space> <Plug>VimwikiToggleListItem

" command mode shortcuts
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>


