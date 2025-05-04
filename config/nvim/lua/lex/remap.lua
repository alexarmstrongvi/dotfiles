-- Workaround for issue with :Texplore in NeoVim
-- Opening a file from :Tabexplore gives the following error:
    -- Error detected while processing function <SNR>55_NetrwBrowseChgDir:
    -- line  172:
    -- E471: Argument required: keepj keepalt 2wincmd 1
-- vim.keymap.set('n', '<leader>te', ':tabnew<CR>:Lexplore<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>?', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- vim.keymap.set('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float(nil, {scope="line"})<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float(nil, {scope="line"})<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>fu',
    require("telescope.builtin").lsp_references,
    { desc = 'Telescope find references' }
)

