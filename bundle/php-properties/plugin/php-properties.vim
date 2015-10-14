
function! s:PHPSubscriptToProperty()
	normal hf[2s->t]xx
	silent! call repeat#set("\<Plug>PHPSubscriptToProperty")
endfunction

function! s:PHPPropertyToSubscript()
	normal hf-2s['ea']
	silent! call repeat#set("\<Plug>PHPPropertyToSubscript")
endfunction

nnoremap <silent> <Plug>PHPSubscriptToProperty :<C-U>call <SID>PHPSubscriptToProperty()<CR>
nnoremap <silent> <Plug>PHPPropertyToSubscript :<C-U>call <SID>PHPPropertyToSubscript()<CR>


