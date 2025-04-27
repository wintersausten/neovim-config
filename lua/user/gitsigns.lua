local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  cmd = "Gitsigns",
}
M.config = function()
  local icons = require "user.icons"

  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = true })
  end

  map("n", "<leader>gR", function()
    require("gitsigns").reset_buffer()
  end, "Reset Buffer")

  map("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff")

  map("n", "<leader>gj", function()
    require("gitsigns").next_hunk({ navigation_message = false })
  end, "Next Hunk")

  map("n", "<leader>gk", function()
    require("gitsigns").prev_hunk({ navigation_message = false })
  end, "Prev Hunk")

  map("n", "<leader>gl", function()
    require("gitsigns").blame_line()
  end, "Blame")

  map("n", "<leader>gp", function()
    require("gitsigns").preview_hunk()
  end, "Preview Hunk")

  map("n", "<leader>gr", function()
    require("gitsigns").reset_hunk()
  end, "Reset Hunk")

  map("n", "<leader>gs", function()
    require("gitsigns").stage_hunk()
  end, "Stage Hunk")

  map("n", "<leader>gu", function()
    require("gitsigns").undo_stage_hunk()
  end, "Undo Stage Hunk")

  require("gitsigns").setup {
    signs = {
      add = {
        text = icons.ui.BoldLineMiddle,
      },
      change = {
        text = icons.ui.BoldLineDashedMiddle,
      },
      delete = {
        text = icons.ui.TriangleShortArrowRight,
      },
      topdelete = {
        text = icons.ui.TriangleShortArrowRight,
      },
      changedelete = {
        text = icons.ui.BoldLineMiddle,
      },
    },
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    update_debounce = 200,
    max_file_length = 40000,
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  }
  vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitSignsAdd' })
  vim.api.nvim_set_hl(0, 'GitSignsAddLn', { link = 'GitSignsAddLn' })
  vim.api.nvim_set_hl(0, 'GitSignsAddNr', { link = 'GitSignsAddNr' })

  vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitSignsChange' })
  vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { link = 'GitSignsChangeLn' })
  vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'GitSignsChangeNr' })

  vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'GitSignsChange' })
  vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn', { link = 'GitSignsChangeLn' })
  vim.api.nvim_set_hl(0, 'GitSignsChangedeleteNr', { link = 'GitSignsChangeNr' })

  vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitSignsDelete' })
  vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { link = 'GitSignsDeleteLn' })
  vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'GitSignsDeleteNr' })

  vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'GitSignsDelete' })
  vim.api.nvim_set_hl(0, 'GitSignsTopdeleteLn', { link = 'GitSignsDeleteLn' })
  vim.api.nvim_set_hl(0, 'GitSignsTopdeleteNr', { link = 'GitSignsDeleteNr' })

end

return M
