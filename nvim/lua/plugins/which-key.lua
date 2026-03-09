return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			delay = 1000, -- delay before showing which-key popup (ms)
			preset = "modern",
		})

		-- Register key groups based on actual keymaps
		wk.add({
			{ "<leader>b", group = "Buffer" }, -- <leader>bd, <leader>bD, <leader>bp
			{ "<leader>c", group = "Code" }, -- <leader>ca (code actions), <leader>cl (lint)
			{ "<leader>e", group = "Explorer" }, -- <leader>e* (neo-tree)
			{ "<leader>f", group = "Find" }, -- <leader>f* (telescope)
			{ "<leader>g", group = "Git Diff" }, -- <leader>g* (diffview)
			{ "<leader>h", group = "Git Hunks" }, -- <leader>h* (gitsigns)
			{ "<leader>l", group = "LSP" }, -- <leader>lr (restart LSP)
			{ "<leader>L", group = "LeetCode" }, -- <leader>L* (leetcode)
			{ "<leader>m", group = "Format" }, -- <leader>mp (format)
			{ "<leader>r", group = "Refactor" }, -- <leader>rn (rename)
			{ "<leader>s", group = "Selection" }, -- <leader>s* (treesitter)
			{ "<leader>w", group = "Workspace" }, -- <leader>w* (session)
			{ "<leader>t", group = "Trouble" }, -- <leader>t* (trouble)
		})
	end,
}
