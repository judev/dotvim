
" avoid proliferation of fugitive buffers (http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/)
autocmd BufReadPost fugitive://* set bufhidden=delete

let g:fugitive_gitlab_domains = ['https://code.medshr.org', 'https://code.cuttlefish.com']

" vim-commentary
nmap <leader>/ gcc

" Nerd Tree settings
nmap <leader>z :NERDTreeFind<CR>
nmap <leader>x :NERDTreeFocus<CR>
nmap <leader>X :NERDTreeToggle<CR>

" Don't separate directories and files
let NERDTreeSortOrder=[]

" Use F1 for Nerd Tree help
autocmd FileType nerdtree noremap <buffer> <F1> <nop>
let NERDTreeMapHelp="<F1>"

" Set relativenumber in Nerd Tree buffers
if v:version >= 703
	autocmd FileType nerdtree setlocal relativenumber
endif

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

let g:netrw_altv = 1
" use directory listing cache only remotely
let g:netrw_fastbrowse = 1
" default to tree listing style
let g:netrw_liststyle = 3
" remove default of putting directories first
let g:netrw_sort_sequence = "\<core\%(\.\d\+\)\=\>,\.h$,\.c$,\.cpp$,\~\=\*$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$"


" Syntastic config

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']

" typescript

let g:typescript_compiler_binary = "./node_modules/typescript/bin/tsc"
let g:typescript_compiler_options = "--jsx preserve --noEmit -b"

" text

:command! -range=% -nargs=0 T2S execute "<line1>,<line2>s/^\\t\\+/\\=substitute(submatch(0), '\\t', repeat(' ', ".&ts."), 'g')"
:command! -range=% -nargs=0 S2T execute "<line1>,<line2>s/^\\( \\{".&ts."\\}\\)\\+/\\=substitute(submatch(0), ' \\{".&ts."\\}', '\\t', 'g')"

function! Textwrap()
	setlocal wrap
	setlocal linebreak
	setlocal nolist
	setlocal textwidth=0
	setlocal wrapmargin=0
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vdebug settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:vdebug_options')
	let g:vdebug_options = {}
endif
let g:vdebug_options.port = 9003


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <leader>_ Toggle iskeyword contain or not contain '_'
" <leader>- Toggle iskeyword contain or not contain '-'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>_ :call <SID>ToggleIsKeyword('_')<CR>
nnoremap <leader>- :call <SID>ToggleIsKeyword('-')<CR>

function! s:ToggleIsKeyword(char)
  if stridx(&iskeyword, ','.a:char) < 0
    exec 'setlocal iskeyword+=' . a:char
    echo '&iskeyword now contains "' . a:char . '"'
  else
    exec 'setlocal iskeyword-=' . a:char
    echo '&iskeyword no longer contains "' . a:char . '"'
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHP copy __construct parameters to $this assignment
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=0 PHPConstruct :call <SID>PHP__ConstructArgs()

function! s:PHP__ConstructArgs()
  normal ?__construct?ewyi(o":s/ = [^ ,]\+//ge:s/\$\([a-z0-9_]\+\)/$this->\1 = $\1;/ge:s/, /\r/ge=i{
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Qargs - Copy Quickfix list to args
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add selecta mapping if installed (https://github.com/garybernhardt/selecta)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable("selecta")
  " Run a given vim command on the results of fuzzy selecting from a given shell
  " command. See usage below.
  " Optional 3rd parameter is passed as stdin to choice_command.
  function! SelectaCommand(choice_command, vim_command, ...)
    try
      if a:0 > 0
        silent! exec a:vim_command . " " . system(a:choice_command . " | selecta", a:1)
      else
        silent! exec a:vim_command . " " . system(a:choice_command . " | selecta")
      endif
    catch /Vim:Interrupt/
      " Swallow the ^C so that the redraw below happens; otherwise there will be
      " leftovers from selecta on the screen
    endtry
    redraw!
  endfunction

  " Fuzzy select project files. Open the selected file with :e.
  " Selecting seems to work better for me with paths sorted by length, ascending.
  noremap <leader>f :call SelectaCommand("git ls-files -cdmo \| perl -e 'print sort {length $a <=> length $b} <>'", ":e")<cr>

  " Fuzzy select buffers using selecta
  function! SelectaBuffers(vim_command)
    redir => l:buffers
    silent buffers
    redir END
    silent call SelectaCommand("sed -n 's/.*\"\\(.*\\)\".*/\\1/p'", a:vim_command, l:buffers)
  endfunction

  noremap <leader>b :call SelectaBuffers(":b")<cr>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scratch buffer editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! ScratchEdit(cmd, options)
  exe a:cmd tempname()
  setl buftype=nofile bufhidden=wipe nobuflisted
  if !empty(a:options) | exe 'setl' a:options | endif
endfunction

command! -bar -nargs=* Sedit call ScratchEdit('edit', <q-args>)
command! -bar -nargs=* Ssplit call ScratchEdit('split', <q-args>)
command! -bar -nargs=* Svsplit call ScratchEdit('vsplit', <q-args>)
command! -bar -nargs=* Stabedit call ScratchEdit('tabe', <q-args>)
command! -bar -nargs=* Scratch call ScratchEdit('vsplit', <q-args>)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open a Scratch buffer with contents of templates/scratch.{filetype}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ScratchTemplate(filetype)
  call ScratchEdit('edit', 'ft='.a:filetype)
  0,$d
  exe "read " . g:vim_dir . "/templates/scratch." . a:filetype
  0d
endfunction

command! -nargs=1 TScratch call ScratchTemplate(<f-args>)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reformat C-style language to my preferred style (open brace on same line as
" if / for / etc)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ReformatBraces()
  FixWhitespace
  g/^[\t ]*{/normal kJ
endfunction
" } " << commented brace fixes syntax highlighting below here.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Regenerate tags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CTags()
  if exists(':Dispatch') == 2
    Dispatch! find . -name '*.php' -newer .tags | ctags -f .tags -L -
  else
    exec system("find . -name '*.php' -newer .tags | ctags -f .tags -L - 2>/dev/null")
  endif
endfunction
set tags=.tags

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Just like windo, but restore the current window when done.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! WinDo(command)
  let currwin=winnr()
  execute 'windo ' . a:command
  execute currwin . 'wincmd w'
endfunction
command! -nargs=+ -complete=command Windo call WinDo(<q-args>)

" Just like Windo, but disable all autocommands for super fast processing.
command! -nargs=+ -complete=command Windofast noautocmd call WinDo(<q-args>)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Just like bufdo, but restore the current buffer when done.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
command! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle paste and redraw statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! TogglePasteMode()
  set paste!
  Windofast redrawstatus
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle unnamed clipboard and redraw statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToggleUnnamedClipboard()
  if &clipboard == 'unnamed'
    set clipboard=
  else
    set clipboard=unnamed
  endif
  Windofast redrawstatus
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Help for current word
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SophHelp()
  if &buftype=="help" && match( strpart( getline("."), col(".")-1,1), "\\S")<0
    bw
  else
    try
      exec "help ".expand("<cWORD>")
    catch /:E149:\|:E661:/
      " E149 no help for <subject>
      " E661 no <language> help for <subject>
      try
        exec "help ".expand("<cword>")
      catch /:E149:\|:E661:/
        " E149 no help for <subject>
        " E661 no <language> help for <subject>
        exec "normal K"
      endtry
    endtry
  endif
endfunc

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
