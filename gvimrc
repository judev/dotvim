"set cuc
"set cul

function Fullscreen()
	set columns=230
	set lines=57
endfunction

command! Fullscreen :call Fullscreen()

function Halfscreen()
	set columns=115
endfunction

command! Halfscreen :call Halfscreen()

