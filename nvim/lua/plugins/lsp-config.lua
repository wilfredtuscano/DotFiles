return {
    -- Mason (tool installer)
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                }
            })
        end
    },

    -- Mason tool installer (auto-install formatters)
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        opts = {
            ensure_installed = {
                -- Formatters (for conform.nvim)
                "prettier",
                "stylua", 
                -- "isort",     -- Disabled: requires Python 3.10+
                -- "black",     -- Disabled: requires Python 3.10+
                "google-java-format",
                "ktlint",
                "nginx-config-formatter",
                
                -- Linters (for nvim-lint)
                "flake8",    -- Python linting
                "eslint_d",  -- Fast ESLint for JS/TS
            },
        },
    },

    -- Mason LSP config (bridges Mason + LSP)
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "eslint",
                    "cssls",
                    "html",
                    "kotlin_language_server",
                    "pyright",
                    "jdtls",
                    "nginx_language_server"
                },
                -- Disable auto-setup for all servers; vim.lsp.config + vim.lsp.enable handles it
                handlers = {
                    function() end,
                },
            })
        end
    },

    -- LSP config
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
        config = function()
            -- Broadcast nvim-cmp LSP capabilities to all servers
            vim.lsp.config("*", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            -- Use modern vim.lsp.config (Neovim 0.11+)
            vim.lsp.config("lua_ls", {
                cmd = { "lua-language-server" },
                root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml" },
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }  -- Recognize 'vim' global
                        }
                    }
                }
            })

            vim.lsp.config("ts_ls", {
                cmd = { "typescript-language-server", "--stdio" },
                root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = 'all',
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        }
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = 'all',
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        }
                    }
                }
            })

            vim.lsp.config("eslint", {
                cmd = { "vscode-eslint-language-server", "--stdio" },
                root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", "eslint.config.js" }
            })

            vim.lsp.config("cssls", {
                cmd = { "vscode-css-language-server", "--stdio" },
                root_markers = { "package.json" }
            })

            vim.lsp.config("html", {
                cmd = { "vscode-html-language-server", "--stdio" },
                root_markers = { "package.json" }
            })

            vim.lsp.config("pyright", {
                cmd = { "pyright-langserver", "--stdio" },
                root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "pyrightconfig.json" }
            })

            vim.lsp.config("nginx_language_server", {
                cmd = { "nginx-language-server" },
                root_markers = { "nginx.conf", ".nginx" }
            })

            vim.lsp.config("jdtls", {
                cmd = {
                    "jdtls",
                    "--data", vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
                },
                root_markers = { "pom.xml", "build.gradle", "build.gradle.kts", ".git" },
                filetypes = { "java" },
            })

            vim.lsp.config("kotlin_language_server", {
                cmd = { "kotlin-language-server" },
                root_markers = { "build.gradle", "build.gradle.kts", "settings.gradle", "settings.gradle.kts", "pom.xml" },
                filetypes = { "kotlin" },
            })

            -- Enable LSP servers
            vim.lsp.enable({ "lua_ls", "ts_ls", "eslint", "cssls", "html", "pyright", "nginx_language_server", "jdtls", "kotlin_language_server" })

            -- LSP keybindings on attach
            local keymap = vim.keymap -- for conciseness
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Buffer local mappings.
                    local opts = { buffer = ev.buf, silent = true }

                    -- set keybinds
                    opts.desc = "Show LSP references"
                    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                    opts.desc = "Go to declaration"
                    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                    opts.desc = "Show LSP definition"
                    keymap.set("n", "gd", vim.lsp.buf.definition, opts)

                    opts.desc = "Show LSP implementations"
                    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                    opts.desc = "Show LSP type definitions"
                    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                    opts.desc = "See available code actions"
                    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                    opts.desc = "Smart rename"
                    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                    opts.desc = "Show line diagnostics"
                    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                    opts.desc = "Go to previous diagnostic"
                    keymap.set("n", "[d", function()
                        vim.diagnostic.jump({ count = -1, float = true })
                    end, opts)

                    opts.desc = "Go to next diagnostic"
                    keymap.set("n", "]d", function()
                        vim.diagnostic.jump({ count = 1, float = true })
                    end, opts)

                    opts.desc = "Show documentation for what is under cursor"
                    keymap.set("n", "K", function()
                        vim.lsp.buf.hover({ border = "rounded" })
                    end, opts)

                    opts.desc = "Restart LSP"
                    keymap.set("n", "<leader>lr", ":LspRestart<CR>", opts)
                end,
            })

            -- Configure diagnostic icons
            local severity = vim.diagnostic.severity
            vim.diagnostic.config({
                float = {
                    border = "rounded",
                    source = true,
                    header = "",
                    prefix = "",
                },
                signs = {
                    text = {
                        [severity.ERROR] = " ",
                        [severity.WARN] = " ",
                        [severity.HINT] = "󰠠 ",
                        [severity.INFO] = " ",
                    },
                },
            })
        end
    }
}
