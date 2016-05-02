" css-doc.vim - CSS Doc
" currently OSX only, need to use open-browser.vim or similar to
" make it x-platform. http://www.vim.org/scripts/script.php?script_id=3133
" Maintainer:   Jude Venn

" Exit quickly when:
" - when 'compatible' is set
if &cp
    finish
endif

nmap <buffer>K :!open https://developer.mozilla.org/en/docs/Web/CSS/<cword><CR><CR>

" vim:set ft=vim ts=8 sw=4 sts=4:
