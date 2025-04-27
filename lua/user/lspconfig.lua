local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/neodev.nvim",
    },
  },
}

local function lsp_keymaps(bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
  end

  map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
  map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
  map("n", "gT", vim.lsp.buf.type_definition, "Go to Type Definition")
  map("n", "gI", vim.lsp.buf.implementation, "Go to Implementation")
  map("n", "gr", vim.lsp.buf.references, "Go to References")
  map("n", "gl", vim.diagnostic.open_float, "Show Diagnostics")
  map("n", "K", function()
    vim.lsp.buf.hover { border = "single", max_height = 25 }
  end, "Hover Documentation")
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  if client.supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(true, { bufnr })
  end
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

M.toggle_inlay_hints = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
end

function M.config()
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { desc = desc, noremap = true, silent = true })
  end

  map("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true, filter = function(client) return client.name ~= "tsserver" end })
  end, "Format")

  map("n", "<leader>lh", function()
    require("user.lspconfig").toggle_inlay_hints()
  end, "Hints")

  map("n", "<leader>li", "<cmd>LspInfo<cr>", "Info")
  map("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic")
  map("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic")
  map("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action")
  map("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix")
  map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename")

  map("v", "<leader>laa", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action (Visual)")

  local icons = require "user.icons"

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
      },
    },
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = true,
      header = "",
      prefix = "",
    },
  })
  -- vim.o.winborder = 'rounded'
  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  -- require("lspconfig.ui.windows").default_options.border = "rounded"



  require("mason-lspconfig").setup_handlers {
    function(server_name)
      local opts = {
        on_attach = M.on_attach,
        capabilities = M.common_capabilities(),
      }

      -- Load user.lspsettings.SERVER.lua if it exists
      local ok, custom = pcall(require, "user.lspsettings." .. server_name)
      if ok then
        opts = vim.tbl_deep_extend("force", opts, custom)
      end

      -- Special setup for Lua LSP
      if server_name == "lua_ls" then
        require("neodev").setup({})
      end

      require("lspconfig")[server_name].setup(opts)
    end,
  }
end

return M
