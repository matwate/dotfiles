vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.clipboard = "unnamedplus"
-- remap ctrl + D and ctrl + u to do the same but with zz after
vim.cmd("nnoremap <C-d> <C-d>zz")
vim.cmd("nnoremap <C-u> <C-u>zz")
vim.g.mapleader = " "
vim.wo.relativenumber = true
vim.wo.number = true

-- Load custom keymaps
require("matwa-keymaps")
