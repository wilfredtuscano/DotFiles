-- lazygit.nvim - lazygit (git TUI) integrated into Neovim
-- Opens lazygit in a floating window, scoped to the repo of the current file.
-- Requires the `lazygit` CLI (installed via Brewfile).

return {
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- Lazy-load: the plugin only loads the first time one of these commands/keys is used.
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  keys = {
    -- Use the git repo of the CURRENT FILE, not nvim's cwd. Launching from a parent directory
    -- that is not itself a repo (e.g. ~/hq, or any folder holding several repos) would otherwise
    -- give lazygit nothing to show.
    { "<leader>gg", "<cmd>LazyGitCurrentFile<CR>", desc = "LazyGit (current file's repo)" },
  },
}
