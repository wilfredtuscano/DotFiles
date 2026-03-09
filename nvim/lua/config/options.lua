-- ============================================================================
-- NEOVIM OPTIONS
-- ============================================================================

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Indentation (default for most languages)
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- UI
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.cursorline = true
-- opt.wrap = false
-- opt.colorcolumn = "80"

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Mouse
opt.mouse = "a"

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300

-- Backup and swap (git + auto-session handle recovery)
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.undodir"

-- Completion
opt.completeopt = "menu,menuone,noselect"
