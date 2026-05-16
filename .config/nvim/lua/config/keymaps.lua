local map = vim.keymap.set

-- Set space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear search highlights easily
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlights" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
