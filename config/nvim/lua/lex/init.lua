print("Loading lua/lex select packages")

-- Make backup dir location similar to undo and swap directory
vim.opt.backupdir = vim.fn.stdpath('state') .. "/backup//"

-- Ensure directories exist
vim.fn.mkdir(vim.opt.undodir:get()[1], "p")
vim.fn.mkdir(vim.opt.backupdir:get()[1], "p")
vim.fn.mkdir(vim.opt.directory:get()[1], "p")

-- Python setup
vim.g.python3_host_prog = vim.fn.stdpath('data') .. "/pyvenv/bin/python"

-- require('lex.options') -- Set with vimrc config
-- require('lex.keymaps')
require('lex.plugin_manager_bootstrap')
require('lex.install_plugins')
require('lex.remap')
