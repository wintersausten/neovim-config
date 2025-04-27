local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    -- general tests
    "vim-test/vim-test",
    "nvim-neotest/neotest-vim-test",
    -- language specific tests
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
    "rouge8/neotest-rust",
    "lawrence-laz/neotest-zig",
    "rcasia/neotest-bash",
    "nvim-neotest/nvim-nio",
  },
}

function M.config()
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = true })
  end

  map("n", "<leader>ta", function()
    require("neotest").run.attach()
  end, "Attach Test")

  map("n", "<leader>td", function()
    require("neotest").run.run({ strategy = "dap" })
  end, "Debug Test")

  map("n", "<leader>tf", function()
    require("neotest").run.run(vim.fn.expand("%"))
  end, "Test File")

  map("n", "<leader>ts", function()
    require("neotest").run.stop()
  end, "Test Stop")

  map("n", "<leader>tt", function()
    require("neotest").run.run()
  end, "Test Nearest")

  ---@diagnostic disable: missing-fields
  require("neotest").setup {
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
      },
      require "neotest-vitest",
      require "neotest-zig",
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua", "javascript", "typescript" },
      },
    },
  }
end

return M
