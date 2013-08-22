
"if has("gui_macvim")
	"let g:script_runner_key = '<D-r>'
"else
	let g:script_runner_key = '<F6>'
"endif

" <leader>f to open CtrlP
nmap <leader>f :CtrlP<cr>
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" yankring
let g:yankring_replace_n_pkey = '<leader>p'
let g:yankring_replace_n_nkey = '<leader>P'
" <leader>r to show the yankring
nmap <leader>r :YRShow<cr>

" Fugitive
" ,g for Ggrep
nmap <leader>g :Ggrep 
" avoid proliferation of fugitive buffers (http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/)
autocmd BufReadPost fugitive://* set bufhidden=delete

" vim-commentary
nmap <leader>/ gcc

" Ack
" ,a for Ack
nmap <leader>a :Ack 

" Nerd Tree settings
nmap <leader>z :NERDTreeFind<CR>
nmap <leader>x :NERDTreeFocus<CR>
nmap <leader>X :NERDTreeToggle<CR>
nmap <leader>c :NERDTreeFromBookmark 

" Don't separate directories and files
let NERDTreeSortOrder=[]

" Use F1 for Nerd Tree help
autocmd FileType nerdtree noremap <buffer> <F1> <nop>
let NERDTreeMapHelp="<F1>"

" Set relativenumber in Nerd Tree buffers
if v:version >= 703
	autocmd FileType nerdtree setlocal relativenumber
endif


nmap <leader>b :Bufferlist<CR>

nnoremap <F5> :GundoToggle<CR>

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXTRACT VARIABLE (SKETCHY)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ExtractVariable()
    let name = input("Variable name: ")
    if name == ''
        return
    endif
    " Enter visual mode (not sure why this is needed since we're already in
    " visual mode anyway)
    normal! gv

    " Replace selected text with the variable name
    exec "normal c" . name
    " Define the variable on the line above
    exec "normal! O" . name . " = "
    " Paste the original selected text to be the variable value
    normal! $p
	if (&filetype == 'php' || &filetype == 'javascript' || &filetype == 'c')
		normal! A;
	endif
endfunction
vnoremap <leader>x :call ExtractVariable()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unit Testing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi GreenBar term=reverse ctermfg=black ctermbg=green guifg=white guibg=green
hi RedBar   term=reverse ctermfg=white ctermbg=red guifg=white guibg=red

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

