local M = {
  "mfussenegger/nvim-lint",
}

function M.config()
  local lint = require("lint")

  lint.linters_by_ft = {
    typescript = {'eslint_d'},
    typescriptreact = {'eslint_d'},
    javascript = {'eslint_d'},
    javascriptreact = {'eslint_d'}
  }

  vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
    callback = function()
      require("lint").try_lint()
    end
  })
end

return M
