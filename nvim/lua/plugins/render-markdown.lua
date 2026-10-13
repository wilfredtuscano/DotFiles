return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {},
  keys = {
    { "<leader>mdt", "<cmd>RenderMarkdown buf_toggle<cr>", desc = "Toggle markdown preview" },
    { "<leader>mds", "<cmd>RenderMarkdown preview<cr>", desc = "Side-by-side (raw | preview)" },
  },
}
