-- ============================================================================
-- NEOVIM AUTOCOMMANDS
-- ============================================================================

-- Auto-reload buffers when their file changes on disk (e.g. edited by agents),
-- as long as the buffer has no unsaved changes. autoread is already on; these
-- autocmds trigger the check. CursorHold fires after updatetime (250ms) idle.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "checktime",
})

-- Let you know when a buffer was reloaded from disk.
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("Buffer reloaded (changed on disk)", vim.log.levels.WARN)
  end,
})
