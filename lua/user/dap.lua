local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    {                      -- Mason integration
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "williamboman/mason.nvim" },
      opts = {
        automatic_installation = true,
        ensure_installed = { "js-debug-adapter" },
        handlers = {},
      },
    },
    { "rcarriga/nvim-dap-ui",        opts = {} },
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
  },
}

---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
  local args  = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  local asstr = type(args) == "table" and table.concat(args, " ") or args
  config      = vim.deepcopy(config)
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", asstr))
    if config.type == "java" then return new_args end
    return require("dap.utils").splitstr(new_args)
  end
  return config
end

function M.config()
  local dap = require("dap")

  vim.api.nvim_set_hl(0, "DapStoppedLine", { link = "Visual", default = true })
  for name, icon in pairs({ Breakpoint = "", Stopped = "" }) do
    vim.fn.sign_define("Dap" .. name, { text = icon, texthl = "DiagnosticInfo" })
  end

  local map = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { desc = "DAP: " .. desc })
  end
  map("<leader>db", dap.toggle_breakpoint,           "Toggle breakpoint")
  map("<leader>dB", function() dap.set_breakpoint(vim.fn.input "Condition: ") end,
      "Breakpoint w/ condition")
  map("<leader>dc", dap.continue,                    "Continue / start")
  map("<leader>da", function() dap.continue { before = get_args } end, "Run with args")
  map("<leader>dC", dap.run_to_cursor,               "Run to cursor")
  map("<leader>di", dap.step_into,                   "Step into")
  map("<leader>dO", dap.step_over,                   "Step over")
  map("<leader>do", dap.step_out,                    "Step out")
  map("<leader>dP", dap.pause,                       "Pause")
  map("<leader>dt", dap.terminate,                   "Terminate")
  map("<leader>dr", dap.repl.toggle,                 "Toggle REPL")
  map("<leader>dl", dap.run_last,                    "Run last")
  map("<leader>dw", require("dap.ui.widgets").hover, "Widgets hover")

  local registry = require("mason-registry")
  local ok, pkg  = pcall(registry.get_package, "js-debug-adapter")
  if ok and not dap.adapters["pwa-node"] then
    local dbg_path = pkg:get_install_path() .. "/js-debug/src/dapDebugServer.js"
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = { command = "node", args = { dbg_path, "${port}" } },
    }
    dap.adapters["node"] = function(cb, cfg)
      if cfg.type == "node" then cfg.type = "pwa-node" end
      cb(dap.adapters["pwa-node"])
    end
  end

  local js_ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
  for _, ft in ipairs(js_ft) do
    dap.configurations[ft] = dap.configurations[ft] or {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to pid",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
  end

  local vscode = require("dap.ext.vscode")
  local json   = require("plenary.json")

  vscode.json_decode = function(str)
    return vim.json.decode(json.json_strip_comments(str))
  end

  vscode.type_to_filetypes["pwa-node"] = js_ft
  vscode.type_to_filetypes["node"]     = js_ft

  local dapui = require("dapui")
  dapui.setup()
  dap.listeners.after.event_initialized["dapui"] = function() dapui.open()  end
  dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui"]     = function() dapui.close() end
  vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP-UI toggle" })
  vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "DAP-UI eval" })
end

return M
