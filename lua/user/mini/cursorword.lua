local M = {
  "echasnovski/mini.cursorword",
  event = "VeryLazy",
  config = function()
    require("mini.cursorword").setup()

    local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    local base_bg = normal_hl.bg or 0x000000 -- fallback if bg not found

    -- Lighten it slightly for highlighting
    local function lighten(color, amount)
      return math.min(color + amount, 0xFFFFFF)
    end

    vim.api.nvim_set_hl(0, "MiniCursorword", { underline = false, bg = string.format("#%06x", lighten(base_bg, 0x202020)) })
    vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = false, bg = string.format("#%06x", lighten(base_bg, 0x303030)) })

    -- Disable cursorword highlighting in specific filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "mason",
        "harpoon",
        "DressingInput",
        "NeogitCommitMessage",
        "qf",
        "dirvish",
        "oil",
        "minifiles",
        "fugitive",
        "alpha",
        "NvimTree",
        "lazy",
        "NeogitStatus",
        "Trouble",
        "netrw",
        "lir",
        "DiffviewFiles",
        "Outline",
        "Jaq",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
      },
      callback = function()
        vim.b.minicursorword_disable = true
      end,
    })
  end,
}

return M
