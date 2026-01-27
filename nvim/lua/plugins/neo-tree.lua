return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
        require("neo-tree").setup({
            close_if_last_window = false,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = true,
                    hide_gitignored = true,
                },
                follow_current_file = {
                    enabled = false,
                },
                use_libuv_file_watcher = true,
            },
        })
        vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = "Toggle file explorer" })
        vim.keymap.set('n', '<leader>ee', ':Neotree focus<CR>', { desc = "Focus file explorer" })
        vim.keymap.set('n', '<leader>ef', ':Neotree reveal<CR>', { desc = "Toggle file explorer on current file" })
        vim.keymap.set('n', '<leader>ec', ':Neotree close<CR>', { desc = "Close file explorer" })
        vim.keymap.set('n', '<leader>er', ':Neotree refresh<CR>', { desc = "Refresh file explorer" })
        vim.keymap.set('n', '<leader>eb', ':Neotree buffers<CR>', { desc = "Show buffers" })
        vim.keymap.set('n', '<leader>eg', ':Neotree git_status<CR>', { desc = "Show git status" })
    end
}

