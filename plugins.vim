
" nerdcommenter
" ,/ to invert comment on the current line/selection
nmap <leader>/ :call NERDComment(0, "invert")<cr>
vmap <leader>/ :call NERDComment(0, "invert")<cr>

" ,t to show tags window
let Tlist_Show_Menu=1
nmap <leader>t :TlistToggle<CR>

" yankring
let g:yankring_replace_n_pkey = '<leader>['
let g:yankring_replace_n_nkey = '<leader>]'
" ,y to show the yankring
nmap <leader>y :YRShow<cr>

" Fugitive
" ,g for Ggrep
nmap <leader>g :Ggrep 
" avoid proliferation of fugitive buffers (http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/)
autocmd BufReadPost fugitive://* set bufhidden=delete

" Ack
" ,a for Ack
nmap <leader>a :Ack 

" ,e to fast finding files. just type beginning of a name and hit TAB
nmap <leader>e :e **/

" ,f to fast finding files using fuzzy finder.
nmap <leader>f :FufFile **/<CR>

" ,b to fast finding files using fuzzy finder.
nmap <leader>b :FufBuffer<CR>

nnoremap <F5> :GundoToggle<CR>

if !exists('g:jv_vimrc_funcs')
    let g:jv_vimrc_funcs = 1
	function InsertTabWrapper()
		let col = col('.') - 1 
		if !col || getline('.')[col - 1] !~ '\k'
			return "\<tab>"
		else
			return "\<c-p>"
		endif
	endfunction
endif

inoremap <tab> <c-r>=InsertTabWrapper()<CR>

