-- Globals
--
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- Options (see :opt)
--
-- 2 moving around, searching and patterns
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 4 displaying text
vim.opt.scroll = 9
vim.opt.scrolloff = 9999
vim.opt.breakindent = true
vim.opt.list = true
vim.opt.listchars = { tab = " ", trail = "‧", nbsp = "␣" }
vim.opt.number = true
vim.opt.relativenumber = true

-- 5 syntax, highlighting and spelling
vim.opt.hlsearch = true
vim.opt.cursorline = true

-- 9 using the mouse
vim.opt.mouse = "a"

-- 10 messages and info
vim.opt.showmode = false

-- 13 tabs and indenting
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true

-- 24 various
vim.opt.signcolumn = "yes"

-- Keymaps
--
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
