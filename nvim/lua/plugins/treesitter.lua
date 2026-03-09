return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local ok, configs = pcall(require, "nvim-treesitter.configs")
        if ok then
            configs.setup({
                ensure_installed = {
                    "lua",
                    "javascript",
                    "typescript",
                    "tsx",
                    "jsx",
                    "html",
                    "css",
                    "scss",
                    "json",
                    "yaml",
                    "markdown",
                    "markdown_inline",
                    "bash",
                    "dockerfile",
                    "gitignore",
                    "vim",
                    "vimdoc",
                    "java",
                    "kotlin",
                    "python"
                },
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<leader>ss",
                        node_incremental = "<leader>si",
                        node_decremental = "<leader>sd",
                    },
                },
            })
        end
    end
}
