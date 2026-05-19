-- Set space as the leader key (Must be set before plugins are loaded)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- UI & Display Configuration
opt.number = true             -- Show absolute line number
opt.relativenumber = true     -- Show relative line numbers
opt.signcolumn = "yes"        -- Always show the sign column to prevent layout shifts
opt.colorcolumn = "80"        -- Vertical ruler at 80 characters
opt.scrolloff = 8             -- Keep 8 lines visible above/below the cursor
opt.wrap = false              -- Disable line wrapping
opt.termguicolors = true      -- Enable 24-bit RGB colors
opt.cursorline = true         -- Highlight the horizontal row of the cursor
opt.wrap = true 	      -- Prevent text overflow. Turn on text wrapping.
opt.linebreak = true          -- Wrap breaks lines at spaces and not between words.

-- Tabs & Indentation
opt.expandtab = true          -- Convert tabs to spaces
opt.tabstop = 2               -- Insert 2 spaces for a tab
opt.softtabstop = 2           -- Number of spaces a tab counts for while editing
opt.shiftwidth = 2            -- Number of spaces inserted for indentation
opt.smartindent = true        -- Insert indents automatically based on code syntax

-- Windows & Splits
opt.splitright = true         -- Open new vertical splits to the right
opt.splitbelow = true         -- Open new horizontal splits below

-- Search Behavior
opt.hlsearch = false          -- Clear search highlights after executing a search
opt.incsearch = true          -- Show search matches dynamically while typing
opt.ignorecase = true         -- Ignore case when searching text...
opt.smartcase = true          -- ...unless the search query contains capital letters

-- File History, Backups, and Performance
opt.swapfile = false          -- Disable swap file creation
opt.backup = false            -- Disable backup file creation
opt.undofile = true           -- Enable persistent undo history across sessions
opt.updatetime = 50           -- Faster completion and diagnostic response time (in ms)

-- Dynamic path resolution for persistent undo directory based on the OS
if vim.fn.has("win32") == 1 then
  opt.undodir = os.getenv("UserProfile") .. "/.vim/undodir"
else
  opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end

-- System Integration
opt.clipboard = "unnamedplus" -- Sync Neovim buffer with the system clipboard
