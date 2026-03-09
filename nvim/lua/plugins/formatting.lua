return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        -- python = { "isort", "black" }, -- Disabled: requires Python 3.10+
        java = { "google-java-format" },
        kotlin = { "ktlint" },
        nginx = { "nginx-config-formatter" },
      },
      formatters = {
        ["google-java-format"] = {
          prepend_args = { "--aosp" }, -- Use AOSP style for 4-space indentation
        },
      },
      format_on_save = {
        lsp_format = "fallback",
        async = false,
        timeout_ms = 3000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_format = "fallback",
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
