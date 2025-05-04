Neovim Configuration
====================

Setup procedure
* `init.vim` - Automatically used to initialize Neovim
    * -> `init_from_vim.lua`
        * -> `lua\lex\init.lua`
            * -> `lua\lex\install_plugins.lua` - LazyVim
            * -> `lua\lex\remap.lua`
        * -> `lua\lex\remap.lua`
* `after/` - Configuration of plugins after they have been setup
    * `after/plugin/init.lua`
    * `after/plugin/*`
