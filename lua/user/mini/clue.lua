local M = {
  "echasnovski/mini.clue",
  event = "VeryLazy",
  config = function()
    local clue = require("mini.clue")
    clue.setup({
      window = {
        config = {
          width = 40,
          border = "rounded",
        },
        delay = 0,
      },
      triggers = {
        { mode = 'n', keys = '<Leader>' },
        { mode = 'v', keys = '<Leader>' },
        { mode = 'n', keys = 'g' }, -- only fire custom g hints
      },
      clues = {
        -- Remove clue.gen_clues.g() entirely to avoid auto-filling junk

        clue.gen_clues.builtin_completion(),
        clue.gen_clues.marks(),
        clue.gen_clues.registers(),
        clue.gen_clues.windows(),
        clue.gen_clues.z(),

        -- Your leader key groups
        { mode = 'n', keys = '<leader>l', desc = '+LSP' },
        { mode = 'n', keys = '<leader>t', desc = '+Test' },
        { mode = 'n', keys = '<leader>g', desc = '+Git' },
        { mode = 'n', keys = '<leader>f', desc = '+Find' },
      },
    })
  end,
}

return M

