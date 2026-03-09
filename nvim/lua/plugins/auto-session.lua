return {
  'rmagatti/auto-session',
  config = function()
    require("auto-session").setup {
      log_level = "error",
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      use_git_branch = false,

      auto_save = true,
      auto_restore = false,
      enabled = true,
    }

    -- Keymaps
    vim.keymap.set("n", "<leader>wr", "<cmd>AutoSession search<CR>", { desc = "Find session" })
    vim.keymap.set("n", "<leader>wR", "<cmd>AutoSession restore<CR>", { desc = "Restore last session" })
    vim.keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session" })
  end,
}
