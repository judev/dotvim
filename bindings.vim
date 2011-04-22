let mapleader = ","

" Don't use Ex mode, use Q for formatting
map Q gq

"make Y consistent with C and D
nnoremap Y y$

" toggle highlight trailing whitespace
nmap <silent> <leader>s :set nolist!<CR>

" ,. to disable search match highlight
nmap <silent> ,. :nohlsearch<CR>
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


nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" w!! to write as root
cmap w!! w !sudo tee % >/dev/null

" ,cd to change working directory to current file directory
nmap <silent> <Leader>cd :cd %:p:h<CR>

" make paste reformat and indent
nnoremap P P'[v']=
nnoremap p p'[v']=
"nnoremap <Esc>P P'[v']=
"nnoremap <Esc>p p'[v']=

nmap ,o o<Esc>k
nmap ,O O<Esc>j

