local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
}

function M.config()
  local icons = require "user.icons"

  require("ibl").setup({
    indent = { char = icons.ui.LineMiddle },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "lazy",
        "Trouble",
        "text",
      },
      buftypes = {
        "terminal",
        "nofile",
      },
    },
  })
end

return M
