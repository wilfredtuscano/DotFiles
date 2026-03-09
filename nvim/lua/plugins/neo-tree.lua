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
        -- Clear any existing Neo-tree buffers on startup
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    local name = vim.api.nvim_buf_get_name(buf)
                    if name:match("neo%-tree") then
                        vim.api.nvim_buf_delete(buf, { force = true })
                    end
                end
            end,
        })

        require("neo-tree").setup({
            close_if_last_window = false,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            source_selector = {
                winbar = false,
                statusline = false,
            },
            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = true,
                    hide_gitignored = true,
                },
                follow_current_file = {
                    enabled = true,
                },
                use_libuv_file_watcher = true,
                hijack_netrw_behavior = "open_current",
                window = {
                    mappings = {
                        ["<space>"] = "none",
                    },
                },
            },
            buffers = {
                follow_current_file = {
                    enabled = true,
                },
            },
            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function()
                        vim.cmd("setlocal relativenumber")
                    end,
                },
            },
        })
        vim.keymap.set('n', '<leader>ee', ':Neotree focus<CR>', { desc = "Focus file explorer" })
        vim.keymap.set('n', '<leader>ef', ':Neotree reveal<CR>', { desc = "Toggle file explorer on current file" })
        vim.keymap.set('n', '<leader>ec', ':Neotree close<CR>', { desc = "Close file explorer" })
        vim.keymap.set('n', '<leader>er', ':Neotree refresh<CR>', { desc = "Refresh file explorer" })
        vim.keymap.set('n', '<leader>eb', ':Neotree buffers<CR>', { desc = "Show buffers" })
        vim.keymap.set('n', '<leader>eg', ':Neotree git_status<CR>', { desc = "Show git status" })
    end
}
