-- Treesitter incremental selection.
--
-- nvim-treesitter's `main` rewrite dropped the incremental_selection module with no
-- replacement and no upstream guidance, so this reimplements it on Neovim's own treesitter
-- API. No plugin needed: vim.treesitter.get_node() plus node:parent() and node:range() is
-- the whole mechanism.
--
--   <leader>ss  start: select the smallest node under the cursor
--   <leader>si  grow:  select the next enclosing node
--   <leader>sd  shrink: step back to the previous selection
--
-- Selection state is a per-buffer stack of nodes. Nodes are only valid while the buffer is
-- unmodified, so any edit means starting again with <leader>ss.

local M = {}

---@type table<integer, TSNode[]>
local stacks = {}

local function leave_visual()
  if vim.fn.mode():match("^[vV\22]") then
    vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true))
  end
end

local function select_node(node)
  local srow, scol, erow, ecol = node:range()

  -- Node ranges are 0-indexed with an EXCLUSIVE end column. Visual marks are 1-indexed with
  -- an INCLUSIVE end, and for the end column those two happen to be the same number. The
  -- exception is a node ending at column 0, which really ends on the previous line.
  if ecol == 0 and erow > srow then
    erow = erow - 1
    ecol = #vim.api.nvim_buf_get_lines(0, erow, erow + 1, true)[1]
  end

  vim.fn.setpos("'<", { 0, srow + 1, scol + 1, 0 })
  vim.fn.setpos("'>", { 0, erow + 1, math.max(ecol, 1), 0 })
  vim.cmd("normal! gv")
end

local function same_range(a, b)
  local a1, a2, a3, a4 = a:range()
  local b1, b2, b3, b4 = b:range()
  return a1 == b1 and a2 == b2 and a3 == b3 and a4 == b4
end

-- Explicit bufnr and pos rather than bare get_node(): the no-argument form depends on
-- implicit window state and returns nil in contexts where the parser is fine but nothing has
-- attached to the window yet.
local function node_at_cursor()
  local pos = vim.api.nvim_win_get_cursor(0)

  -- Make sure a tree exists. get_node() returns nil when nothing has parsed the buffer yet,
  -- which is the case whenever treesitter highlighting is not driving parses for this
  -- filetype. Parsing an already-parsed buffer is a no-op.
  local ok_parser, parser = pcall(vim.treesitter.get_parser, 0)
  if ok_parser and parser then
    pcall(function()
      parser:parse()
    end)
  end

  local ok, node = pcall(vim.treesitter.get_node, { bufnr = 0, pos = { pos[1] - 1, pos[2] } })
  return ok and node or nil
end

function M.init()
  leave_visual()
  local node = node_at_cursor()
  if not node then
    vim.notify("No treesitter node under the cursor", vim.log.levels.WARN)
    return
  end
  stacks[vim.api.nvim_get_current_buf()] = { node }
  select_node(node)
end

function M.grow()
  local buf = vim.api.nvim_get_current_buf()
  local stack = stacks[buf]
  if not stack or #stack == 0 then
    return M.init()
  end
  leave_visual()

  local node = stack[#stack]
  local parent = node:parent()
  -- Skip wrapper nodes that cover exactly the same text, otherwise growing appears to do
  -- nothing for a keypress or two.
  while parent and same_range(parent, node) do
    parent = parent:parent()
  end

  if not parent then
    return select_node(node) -- already at the root
  end
  table.insert(stack, parent)
  select_node(parent)
end

function M.shrink()
  local buf = vim.api.nvim_get_current_buf()
  local stack = stacks[buf]
  if not stack or #stack < 2 then
    return
  end
  leave_visual()
  table.remove(stack)
  select_node(stack[#stack])
end

local function map(lhs, fn, desc)
  vim.keymap.set({ "n", "x" }, lhs, fn, { silent = true, desc = desc })
end

map("<leader>ss", M.init, "Treesitter: select node")
map("<leader>si", M.grow, "Treesitter: grow selection")
map("<leader>sd", M.shrink, "Treesitter: shrink selection")

-- Drop state when a buffer is unloaded so the table does not grow forever.
vim.api.nvim_create_autocmd({ "BufUnload", "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("TsSelectionReset", { clear = true }),
  callback = function(ev)
    stacks[ev.buf] = nil
  end,
})

return M
