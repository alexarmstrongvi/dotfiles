" Load Vim configuration
" See https://neovim.io/doc/user/nvim.html#nvim-from-vim
echom "Autoloading init.vim"
if empty($XDG_CONFIG_HOME)
    let $XDG_CONFIG_HOME = $HOME."/.config"
endif
set runtimepath^=$XDG_CONFIG_HOME/vim
set runtimepath+=$XDG_CONFIG_HOME/vim/after
let &packpath=&runtimepath
source $XDG_CONFIG_HOME/vim/vimrc

" Load Neovim configuration
source $XDG_CONFIG_HOME/nvim/init_from_vim.lua
