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
  },
  keys = {
    { "<leader>Lc", "<cmd>Leet<cr>", desc = "Open LeetCode" },
    { "<leader>Ll", "<cmd>Leet list<cr>", desc = "List LeetCode problems" },
    { "<leader>Lt", "<cmd>Leet test<cr>", desc = "Test LeetCode solution" },
    { "<leader>Ls", "<cmd>Leet submit<cr>", desc = "Submit LeetCode solution" },
    { "<leader>Lr", "<cmd>Leet run<cr>", desc = "Run LeetCode solution" },
    { "<leader>Li", "<cmd>Leet info<cr>", desc = "Show LeetCode problem info" },
  },
}
