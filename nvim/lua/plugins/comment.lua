-- TODO: Remove this plugin when Neovim's built-in commenting (gc/gb operators) 
-- fully supports block comments and all comment types. Currently gb* commands
-- don't work reliably in v0.11.5
return {
  'numToStr/Comment.nvim',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('Comment').setup()
  end,
}

