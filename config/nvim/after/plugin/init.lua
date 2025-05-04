print("Autoloading after/plugin/*")

--------------------------------------------------------------------------------
-- Neovim colorschemes
vim.cmd.colorscheme('vscode') -- Not Working
-- vim.cmd.colorscheme('tokyonight') -- Not Working
-- vim.cmd.colorscheme('rose-pine') -- Not Working
-- Vim colorschemes
-- vim.cmd.colorscheme("gruvbox")
-- vim.cmd.colorscheme("jellybeans")

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})

-- vscode = require('vscode')
-- vscode.setup({
--     italic_comments = true,
-- })
-- vscode.load()

--------------------------------------------------------------------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

--------------------------------------------------------------------------------
require("nvim-surround").setup()
require('mini.align').setup()
require('gitsigns').setup()

--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

--------------------------------------------------------------------------------
local navic = require("nvim-navic")
local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end
}
navic.setup({
    highlight = true,
    lsp = {
        auto_attach = true,
    }
})
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
lspconfig.hls.setup {
    on_attach = function(_, bufnr)
        -- Enable hover to display inferred type
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {
            noremap = true, silent = true
        })
    end
}

--------------------------------------------------------------------------------
local treesitter = require('nvim-treesitter.configs')
local opts = {
    -- A list of parser names, or "all" (the top five listed parsers should always be installed)
    ensure_installed = {
        -- Required by treesitter
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        -- User specific
        "python",
        "cpp",
        "bash",
        "cmake",
        "diff",
        "git_rebase",
        "gitcommit",
        -- "gitignore",
        "make",
        "regex",
        "toml",
        "yaml"
    },
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
treesitter.setup(opts)
