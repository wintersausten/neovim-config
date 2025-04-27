local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}

function M.config()
  local harpoon = require("harpoon")
  harpoon:setup({settings = {save_on_toggle = true}})

  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

-- Append to & show list
  keymap("n", "<leader>m", function() harpoon:list():append() end, opts)
  keymap("n", "<TAB>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts)

-- Quick select from list
  keymap("n", "<leader>q", function() harpoon:list():select(1) end, opts)
  keymap("n", "<leader>w", function() harpoon:list():select(2) end, opts)
  keymap("n", "<leader>e", function() harpoon:list():select(3) end, opts)
  keymap("n", "<leader>r", function() harpoon:list():select(4) end, opts)

-- Toggle previous & next buffers stored within Harpoon list
  keymap("n", "<C-f>", function() harpoon:list():prev() end, opts)
  keymap("n", "<C-d>", function() harpoon:list():next() end, opts)

  harpoon:extend({
    UI_CREATE = function(cx)
      vim.keymap.set("n", "<C-v>", function()
        harpoon.ui:select_menu_item({ vsplit = true })
      end, { buffer = cx.bufnr })

      vim.keymap.set("n", "<C-x>", function()
        harpoon.ui:select_menu_item({ split = true })
      end, { buffer = cx.bufnr })
    end,
  })
end

return M
