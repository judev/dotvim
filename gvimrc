"set cuc
"set cul

function! Fullscreen()
	set columns=230
	set lines=66
endfunction

command! Fullscreen :call Fullscreen()

function! Halfscreen()
	set columns=115
endfunction

command! Halfscreen :call Halfscreen()

call Fullscreen()

