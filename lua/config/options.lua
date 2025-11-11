vim.o.nu = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.termguicolors = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Preview Substitutions
vim.o.inccommand = 'split'

-- Text wrap
--[[ vim.o.wrap = true ]]
vim.o.wrap = false
--[[ vim.o.breakindent = true ]]

-- Tabstops
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Window splitting
vim.o.splitright = true
vim.o.splitbelow = true

-- Save undo history
vim.o.undofile = true

-- Swap File
vim.o.swapfile = false

-- Clipboard
vim.o.clipboard = "unnamedplus"

-- Scroll off
vim.opt.scrolloff = 8 -- minimum number of lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 --minimum number of columns to keep above and below the cursor
