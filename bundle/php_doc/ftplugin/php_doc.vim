" php_doc.vim - Php Doc
" currently OSX only, need to use open-browser.vim or similar to
" make it x-platform. http://www.vim.org/scripts/script.php?script_id=3133
" Maintainer:   Jude Venn

" Exit quickly when:
" - this plugin was already loaded (or disabled)
" - when 'compatible' is set
if (exists("g:loaded_php_doc") && g:loaded_php_doc) || &cp
    finish
endif
let g:loaded_php_doc = 1

nmap <buffer> K :!open http://php.net/<cword><CR><CR>

" vim:set ft=vim ts=8 sw=4 sts=4:
