-- ============================================================================
-- NEOVIM KEYMAPS
-- ============================================================================

local keymap = vim.keymap

-- Save all files with Ctrl+S
keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>wa<CR>", { desc = "Save all files" })

-- Clear search highlighting (commented - uncomment as needed)
-- keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Better window navigation (commented - uncomment as needed)
-- keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
-- keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
-- keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
-- keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows (commented - uncomment as needed)
-- keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
-- keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
-- keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
-- keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting (commented - uncomment as needed)
-- keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
-- keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Move lines up/down (commented - uncomment as needed)
-- keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
-- keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
-- keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better paste (commented - uncomment as needed)
-- keymap.set("v", "p", '"_dP', { desc = "Paste without losing clipboard" })

-- Quick save and quit (commented - uncomment as needed)
-- keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
-- keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
-- keymap.set("n", "<leader>x", ":x<CR>", { desc = "Save and quit" })

-- Buffer navigation (commented - uncomment as needed)
-- keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
-- keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Previous buffer" })
-- keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Split windows (commented - uncomment as needed)
-- keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertically" })
-- keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split horizontally" })
-- keymap.set("n", "<leader>sc", ":close<CR>", { desc = "Close split" })

