-- Diffview.nvim - Git diff viewer and file history browser
-- Provides visual git diffs, merge conflict resolution, and file history

return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "tpope/vim-fugitive" },
  event = "VeryLazy",
  config = function()
    require("diffview").setup({
      diff_binaries = false,    -- Show diffs for binaries
      enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
      git_cmd = { "git" },      -- The git executable followed by default args.
      use_icons = true,         -- Requires nvim-web-devicons
      show_help_hints = true,   -- Show hints for how to open the help panel
      watch_index = true,       -- Update views and index on git index changes.
      icons = {                 -- Only applies when use_icons is true.
        folder_closed = "",
        folder_open = "",
      },
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
      view = {
        -- Configure the layout and behavior of different types of views.
        -- Available layouts:
        --  'diff1_plain'
        --    |'diff2_horizontal'
        --    |'diff2_vertical'
        --    |'diff3_horizontal'
        --    |'diff3_vertical'
        --    |'diff3_mixed'
        --    |'diff4_mixed'
        -- For more info, see ':h diffview-config-view.x.layout'.
        default = {
          -- Config for changed files, and staged files in diff views.
          layout = "diff2_horizontal",
          winbar_info = false,          -- See ':h diffview-config-view.x.winbar_info'
        },
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase.
          layout = "diff3_horizontal",
          disable_diagnostics = true,   -- Temporarily disable diagnostics for conflict buffers while in the view.
          winbar_info = true,           -- See ':h diffview-config-view.x.winbar_info'
        },
        file_history = {
          -- Config for changed files in file history views.
          layout = "diff2_horizontal",
          winbar_info = false,          -- See ':h diffview-config-view.x.winbar_info'
        },
      },
    })

    -- Keymaps
    local keymap = vim.keymap.set
    keymap("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Open Diffview" })
    keymap("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>", { desc = "File History" })
    keymap("n", "<leader>gH", "<cmd>DiffviewFileHistory %<CR>", { desc = "Current File History" })
    keymap("n", "<leader>gc", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" })
    keymap("n", "<leader>gm", "<cmd>DiffviewOpen HEAD~1<CR>", { desc = "Compare with Previous Commit" })
    keymap("n", "<leader>gv", "<cmd>Gvdiffsplit!<CR>", { desc = "3-way merge conflict resolution" })
  end,
}
