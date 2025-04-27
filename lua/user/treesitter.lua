local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "javascript", "typescript", "tsx", "go", "lua", "markdown", "markdown_inline", "bash", "python", "html", "css", "json"},
    highlight = { enable = true },
    indent = { enable = true },
  }
end

return M
