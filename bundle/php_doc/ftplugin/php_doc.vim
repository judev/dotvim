" php_doc.vim - Php Doc
" currently OSX only, need to use open-browser.vim or similar to
" make it x-platform. http://www.vim.org/scripts/script.php?script_id=3133
" Maintainer:   Jude Venn

" Exit quickly when:
" - when 'compatible' is set
if &cp
    finish
endif

if exists("g:isDarwin") && g:isDarwin
    nmap <buffer>K :!open http://php.net/<cword><CR><CR>
else
    function! WebOpen(word)
	call w3m#Open(g:w3m#OPEN_VSPLIT, "http://php.net/".a:word)
	execute 'normal! /'. a:word ."\<cr>"
	execute "normal zt"
    endfunction
    nmap <buffer>K :call WebOpen(expand("<cword>"))<CR><CR>
endif

" vim:set ft=vim ts=8 sw=4 sts=4:
