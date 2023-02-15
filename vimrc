
call pathogen#infect()
set rtp+=/usr/share/doc/fzf/examples/plugin


if has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

source ~/.vim/global.vim
source ~/.vim/bindings.vim
source ~/.vim/plugins.vim

colorscheme jvcolorscheme
set guifont="Meslo LG S DZ:h13"

if filereadable(expand("~/.vim_local"))
  source ~/.vim_local
endif

