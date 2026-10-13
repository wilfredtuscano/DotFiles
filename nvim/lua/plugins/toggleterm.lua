-- toggleterm.nvim - a floating terminal for quick commands and short builds.
--
-- <C-/> toggles it. Toggling only hides the window: the shell keeps running, so a build
-- carries on while you edit. `exit` (or Ctrl-D) closes it for real, and the next <C-/>
-- starts a fresh shell at the git root of whatever file you are in by then.
--
-- Long-running work still belongs in a tmux pane, where the output survives an nvim restart.
--
-- NOT <C-\>: vim-tmux-navigator binds that in tmux's root key table (its "go to last
-- pane" shortcut), which intercepts the keystroke before nvim's terminal emulation ever
-- sees it. <C-/> is unclaimed by both tmux and this config.
--
-- Scrolling and getting back to the prompt: this is an nvim terminal buffer, not a raw
-- tmux pane, so tmux's own copy-mode (<leader>[, Ctrl-p/d under tmux-sensible, etc.) does
-- not apply inside it, and the terminal has its own two modes:
--   - terminal INSERT mode: typing goes to the shell, same as a normal terminal.
--   - terminal NORMAL mode: the buffer behaves like any other nvim buffer. j/k/gg/G/
--     Ctrl-f/Ctrl-b scroll, y yanks into the normal nvim registers, / searches
--     scrollback. Mouse-drag selection also lands you here once the drag finishes.
-- <Esc><Esc> (double, not single) drops insert -> normal; `i` or `a` goes back to the
-- prompt, the same convention nvim's own terminal buffers already use. Double rather
-- than single <Esc>, deliberately: single <Esc> is fzf's own cancel key inside the shell
-- (Ctrl-R history, fzf-tab completion both run as fzf popups INSIDE the terminal, in
-- insert mode), so claiming single <Esc> at the nvim level would break those every time.

local float_term

local function toggle_float_term()
  if not float_term then
    -- Root at the CURRENT FILE's repo, not nvim's cwd: launching from a folder that holds
    -- several repos would otherwise run commands in the wrong place. Same reasoning as the
    -- <leader>gg lazygit binding. Unnamed buffers fall back to the cwd.
    local root = vim.fs.root(0, ".git") or vim.fn.getcwd()

    float_term = require("toggleterm.terminal").Terminal:new({
      dir = root,
      direction = "float",
      hidden = true, -- keep it out of the numbered :ToggleTerm set
      close_on_exit = true,
      on_exit = function()
        float_term = nil -- so the next open recomputes the root
      end,
      on_open = function(term)
        -- Buffer-local on purpose. Global terminal-mode maps would also apply inside the
        -- lazygit float, where they are not wanted. <C-h/j/k/l> are left alone: the shell
        -- needs them (backspace, kill-line, clear) and a float has no splits to move
        -- between.
        local opts = { buffer = term.bufnr, silent = true }

        vim.keymap.set(
          "t",
          "<C-/>",
          toggle_float_term,
          vim.tbl_extend("force", opts, { desc = "Hide floating terminal" })
        )
        -- Also from normal mode: after <Esc><Esc>, or after a mouse-drag selection,
        -- you're in terminal-normal mode, not insert, and the "t"-mode map above
        -- doesn't fire there.
        vim.keymap.set(
          "n",
          "<C-/>",
          toggle_float_term,
          vim.tbl_extend("force", opts, { desc = "Hide floating terminal" })
        )

        -- Double <Esc>, not single: see the file header. Leaves insert mode for
        -- scrolling/yanking/searching the buffer.
        vim.keymap.set(
          "t",
          "<Esc><Esc>",
          [[<C-\><C-n>]],
          vim.tbl_extend("force", opts, { desc = "Terminal: normal mode (scroll/yank/search)" })
        )
      end,
    })
  end

  float_term:toggle()
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-/>", toggle_float_term, mode = "n", desc = "Toggle floating terminal" },
  },
  opts = {
    shade_terminals = false,
    float_opts = {
      border = "curved",
      width = function()
        return math.floor(vim.o.columns * 0.85)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.8)
      end,
    },
  },
}
