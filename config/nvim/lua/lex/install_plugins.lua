--------------------------------------------------------------------------------
-- Declare plugins to install with minimal configuration
-- Preferred that configuration be moved to it's own file
local lazy = require('lazy')

local plugins = {
    -- Language Server Protocol (LSP) configuration and plugins
    require("lex.plugins.lspconfig"),

    -- Highlight, edit, and navigate code
    { 'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },

    -- Colorschemes
    'Mofiqul/vscode.nvim',

    -- Autocompletion
    {
        'saghen/blink.cmp',
        -- event = 'VimEnter',
        version = '1.*',
        dependencies = {
            { -- Snippet Engine
                'L3MON4D3/LuaSnip',
                version = '2.*',
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                opts = {},
            },
            'folke/lazydev.nvim',
        },
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config
        opts = {
            keymap = { preset = 'enter' },
            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono',
            },
            completion = {
                -- By default, you may press `<c-space>` to show the documentation.
                -- Optionally, set `auto_show = true` to show the documentation after a delay.
                documentation = { auto_show = false, auto_show_delay_ms = 500 },
            },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
                providers = {
                    lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
                },
            },

            snippets = { preset = 'luasnip' },

            -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
            -- which automatically downloads a prebuilt binary when enabled.
            --
            -- By default, we use the Lua implementation instead, but you may enable
            -- the rust implementation via `'prefer_rust_with_warning'`
            --
            -- See :h blink-cmp-config-fuzzy for more information
            fuzzy = { implementation = 'lua' },

            -- Shows a signature help window while you type arguments for a function
            signature = { enabled = true },
        },
    },

    -- Detect tabstop and shiftwidth automatically
    'NMAC427/guess-indent.nvim',

    -- Show pending keybinds
    { 'folke/which-key.nvim', event = 'VimEnter' },

    -- "gc" to toggle commenting lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- auto-align
    { 'echasnovski/mini.align', version = '*' }, -- Stable version

    -- Add, change, and delete surrounding objects
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
    },

    -- Set lualine as statusline
    -- See `:help lualine.txt`
    { 'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                icons_enabled = false,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    -- Add indentation guides (i.e. vertical lines identifying code blocks)
    -- See `:help ibl`
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {}},
    -- Add status line with code context (e.g. what function is my cursor in)
    { 'SmiteshP/nvim-navic', dependencies = "neovim/nvim-lspconfig" },
    -- Add indicators for git status of specific lines (i.e. whether they are
    -- new or modified)
    'lewis6991/gitsigns.nvim',
    -- Highlight todo, notes, etc in comments
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false }
    },

    -- Undo Tree
    -- 'mbbill/undotree',

    -- Git integration
    -- 'tpope/vim-fugitive',
    -- 'tpope/vim-rhubarb'

    -- Fuzzy finder
    { 'nvim-telescope/telescope.nvim',
        branch = 'master',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },
}
lazy.setup(plugins)
