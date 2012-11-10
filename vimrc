if !has('ruby')
  let g:LustyJugglerSuppressRubyWarning = 1
endif
if v:version < 702
  let g:loaded_acp = 1
endif

call pathogen#infect()

source ~/.vim/global.vim
source ~/.vim/bindings.vim
source ~/.vim/plugins.vim

if filereadable(expand("~/.vim_local"))
  source ~/.vim_local
endif
