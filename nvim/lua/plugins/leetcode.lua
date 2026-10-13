-- LeetCode practice in Kotlin.
--
-- Solutions are written to:
--   ~/hq/growth/leetcode/problems/<3-digit-id>-<slug>/NN-<slug>.kt
--
-- leetcode.nvim's default is one flat file per problem. The Question:path
-- override below produces the directory-per-problem, numbered-attempt shape
-- that the practice repo uses, so each approach is kept rather than
-- overwritten and the per-problem README stays alongside the code.
--
-- The numbered prefix is load-bearing: latest_solution_number matches on the
-- exact NN-<slug>.<ext> shape, so renaming a file to add a descriptive suffix
-- restarts the counter at 1. Record which approach each number is in the
-- problem's README instead.

local practice_root = "~/hq/growth/leetcode"

local function solution_suffix(question, lang)
  local alt = lang.alt and ("." .. lang.alt) or ""
  return ("%s%s.%s"):format(question.title_slug, alt, lang.ft)
end

local function problem_directory(question)
  return ("%03d-%s"):format(tonumber(question.frontend_id) or 0, question.title_slug)
end

local function latest_solution_number(directory, suffix)
  local latest = 0

  for _, filename in ipairs(vim.fn.readdir(directory:absolute())) do
    local number, candidate_suffix = filename:match("^(%d+)%-(.+)$")
    if candidate_suffix == suffix then
      latest = math.max(latest, tonumber(number) or 0)
    end
  end

  return latest
end

local function configure_problem_directories()
  local config = require("leetcode.config")
  local Question = require("leetcode-ui.question")
  local utils = require("leetcode.utils")

  function Question:path()
    local lang = utils.get_lang(self.lang)
    local directory = config.storage.home:joinpath("problems", problem_directory(self.q))
    directory:mkdir({ parents = true, exists_ok = true })

    local suffix = solution_suffix(self.q, lang)
    local number = math.max(latest_solution_number(directory, suffix), 1)
    local filename = ("%02d-%s"):format(number, suffix)
    self.file = directory:joinpath(filename)
    local existed = self.file:exists()

    if not existed then
      self.file:write(self:snippet(), "w")
    end

    return self.file:absolute(), existed
  end
end

local function start_next_solution()
  local question = require("leetcode.utils").curr_question()
  if not question then
    return
  end

  local current_path = vim.api.nvim_buf_get_name(question.bufnr)
  local current_filename = vim.fn.fnamemodify(current_path, ":t")
  local current_number, suffix = current_filename:match("^(%d+)%-(.+)$")

  if not current_number then
    vim.notify("Current LeetCode solution does not have a number prefix", vim.log.levels.ERROR)
    return
  end

  local next_number = tonumber(current_number) + 1
  local next_filename = ("%02d-%s"):format(next_number, suffix)
  local next_path = vim.fn.fnamemodify(current_path, ":h") .. "/" .. next_filename

  if vim.fn.filereadable(next_path) == 1 then
    vim.notify(next_filename .. " already exists", vim.log.levels.ERROR)
    return
  end

  vim.api.nvim_buf_call(question.bufnr, function()
    vim.cmd.write()
    vim.cmd("saveas " .. vim.fn.fnameescape(next_path))
  end)

  question.file = require("plenary.path"):new(next_path)
  vim.notify("Started LeetCode solution " .. next_filename)
end

return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  opts = {
    arg = "leetcode.nvim",
    lang = "kotlin",
    storage = {
      home = vim.fn.expand(practice_root),
    },
    editor = {
      -- Keep the latest local solution when reopening a solved problem.
      reset_previous_code = false,
    },
    hooks = {
      enter = configure_problem_directories,
    },
  },
  keys = {
    { "<leader>Lc", "<cmd>Leet<cr>", desc = "Open LeetCode" },
    { "<leader>Ll", "<cmd>Leet list<cr>", desc = "List LeetCode problems" },
    { "<leader>Lt", "<cmd>Leet test<cr>", desc = "Test LeetCode solution" },
    { "<leader>Ls", "<cmd>Leet submit<cr>", desc = "Submit LeetCode solution" },
    { "<leader>Lr", "<cmd>Leet run<cr>", desc = "Run LeetCode solution" },
    { "<leader>Li", "<cmd>Leet info<cr>", desc = "Show LeetCode problem info" },
    { "<leader>Ld", "<cmd>Leet desc<cr>", desc = "Toggle LeetCode description" },
    { "<leader>Ln", start_next_solution, desc = "Start next LeetCode solution" },
  },
}
