return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        -- Without this the GitSigns preview highlight groups are never defined at all,
        -- which is why the hunk preview popup drew added and removed lines identically.
        gitsigns = true,
      },
    })
    vim.cmd.colorscheme("catppuccin")

    -- Catppuccin links GitSignsAddPreview and GitSignsDeletePreview to DiffAdd and
    -- DiffDelete, which it keeps deliberately desaturated so diffed text stays readable in
    -- diff-mode. Correct there, but in the gitsigns hunk preview it reads as near-identical
    -- grey. Point them at the real green and red, the same colors already used in the sign
    -- column and by GitSignsAddInline / GitSignsDeleteInline.
    local palette = require("catppuccin.palettes").get_palette("mocha")
    vim.api.nvim_set_hl(0, "GitSignsAddPreview", { fg = palette.green })
    vim.api.nvim_set_hl(0, "GitSignsDeletePreview", { fg = palette.red })
  end,
}
