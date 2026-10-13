-- nvim-treesitter, `main` branch: the rewrite.
--
-- Pinned to `main` deliberately. `master` is the old line and its README states "Neovim 0.10
-- or 0.11 (Neovim 0.12 is not supported)". This machine runs 0.12.x from brew, and running
-- master here produced runtime failures inside Neovim's own treesitter:
--   languagetree.lua:215: attempt to call method 'range' (a nil value)
--
-- The rewrite is a PARSER MANAGER ONLY. The old `nvim-treesitter.configs` module is gone, so
-- `configs.setup{ highlight = ..., indent = ..., incremental_selection = ... }` no longer
-- exists. Highlighting, folding and injections now come from Neovim itself; see
-- :h treesitter-highlight. Indentation is still provided by this plugin but is marked
-- experimental upstream.
--
-- incremental_selection was REMOVED upstream with no replacement. The old <leader>ss /
-- <leader>si / <leader>sd mappings are therefore gone; nothing else referenced them.

local parsers = {
  "bash",
  "css",
  "dockerfile",
  "gitignore",
  "html",
  "java",
  "javascript",
  "json",
  "kotlin",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "scss",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup()

    -- Replaces the old `ensure_installed`. install() is async and skips what is already
    -- present, so this is cheap on every start. Parsers land in the rewrite's install_dir
    -- (stdpath("data")/site), which it prepends to runtimepath.
    local installed = {}
    for _, lang in ipairs(ts.get_installed()) do
      installed[lang] = true
    end
    local missing = vim.tbl_filter(function(lang)
      return not installed[lang]
    end, parsers)
    if #missing > 0 then
      ts.install(missing)
    end

    -- Highlighting and indent are opt-in per buffer in the rewrite. pcall because a buffer's
    -- filetype may have no parser installed, in which case Neovim keeps regex syntax.
    local function enable(buf, ft)
      local lang = vim.treesitter.language.get_lang(ft)
      if not lang then
        return
      end
      if not pcall(vim.treesitter.start, buf, lang) then
        return
      end
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
      callback = function(ev)
        enable(ev.buf, ev.match)
      end,
    })

    -- lazy = false still loads this during startup, which can be AFTER Neovim has already
    -- fired FileType for a file named on the command line. Without this, `nvim foo.lua` would
    -- open with no treesitter highlighting while every later buffer had it.
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local ft = vim.bo[buf].filetype
      if vim.api.nvim_buf_is_loaded(buf) and ft ~= "" then
        enable(buf, ft)
      end
    end
  end,
}
