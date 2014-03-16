
call pathogen#infect()

source ~/.vim/global.vim
source ~/.vim/bindings.vim
source ~/.vim/plugins.vim

colorscheme jvcolorscheme
set guifont=Meslo\ LG\ S\ DZ:h13

if filereadable(expand("~/.vim_local"))
  source ~/.vim_local
endif

