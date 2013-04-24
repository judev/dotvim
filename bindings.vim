"let mapleader = "\\"
"let mapleader = " "
map <space> <leader>

" Don't use Ex mode, use Q for formatting
map Q gq

"make Y consistent with C and D
"nnoremap Y y$

" use <leader>d to delete without clobbering yank
nmap <leader>d "_dd
vmap <leader>d "_d

" toggle highlight trailing whitespace
nmap <silent> <leader>s :set nolist!<CR>

" ,. to disable search match highlight
nmap <silent> <leader>. :nohlsearch<CR>

" turn off search highlighting in insert mode
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch

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

" remap redraw from C-l as we're going to override it below
nmap <leader><C-l> :redraw<CR>

" Easy window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <leader>h <C-w>j<C-w>|
nmap <leader>l <C-w>k<C-w>|
nmap <leader>j <C-w>j<C-w>_
nmap <leader>k <C-w>k<C-w>_

nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

" split window
nmap <leader>swh       :topleft  vnew<CR>
nmap <leader>swl       :botright vnew<CR>
nmap <leader>swk       :topleft  new<CR>
nmap <leader>swj       :botright new<CR>
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>
" split buffer
nmap <leader>sh        :leftabove  vsplit<CR>
nmap <leader>sl        :rightbelow vsplit<CR>
nmap <leader>sk        :leftabove  split<CR>
nmap <leader>sj        :rightbelow split<CR>
nmap <leader>s<left>   :leftabove  vsplit<CR>
nmap <leader>s<right>  :rightbelow vsplit<CR>
nmap <leader>s<up>     :leftabove  split<CR>
nmap <leader>s<down>   :rightbelow split<CR>

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
if exists("g:isDarwin") && g:isDarwin
	nnoremap <MiddleMouse> <Nop>
endif

" command mode shortcuts
"cnoremap <C-x> <C-a>
"cnoremap <C-a> <Home>
"cnoremap <C-e> <End>
"cnoremap <C-p> <Up>
"cnoremap <C-n> <Down>
"cnoremap <C-b> <Left>
"cnoremap <C-f> <Right>
"cnoremap <M-b> <S-Left>
"cnoremap <M-f> <S-Right>

" Map F1 to Esc in insert mode, expand current work in normal mode
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
imap <F1> <Esc>