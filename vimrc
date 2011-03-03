call pathogen#runtime_append_all_bundles()

source ~/.vim/global.vim
source ~/.vim/bindings.vim
source ~/.vim/plugins.vim

set nofoldenable        "dont fold by default "
if filereadable(expand("~/.vim_local"))
  source ~/.vim_local
endif