local M = {
  "echasnovski/mini.comment",
  event = "VeryLazy",
  -- config = function()
  --   local commentstring = require("ts_context_commentstring.internal").calculate_commentstring
  --
  --   require("mini.comment").setup({
  --     options = {
  --       custom_commentstring = function()
  --         return commentstring() or vim.bo.commentstring
  --       end,
  --     },
  --   })
  -- end,
}

return M
