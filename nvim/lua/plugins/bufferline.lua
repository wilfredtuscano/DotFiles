return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        separator_style = "slant",
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true
          }
        },
      },
    })
    
    -- Keymaps
    vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { desc = "Next buffer" })
    vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { desc = "Previous buffer" })
    vim.keymap.set('n', '<leader>bd', function()
      local buf = vim.api.nvim_get_current_buf()
      vim.cmd('BufferLineCyclePrev')
      vim.api.nvim_buf_delete(buf, {})
    end, { desc = "Delete buffer" })
    vim.keymap.set('n', '<leader>bD', function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
          vim.api.nvim_buf_delete(buf, {})
        end
      end
    end, { desc = "Delete all buffers" })
    vim.keymap.set('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', { desc = "Pin buffer" })
  end,
}
