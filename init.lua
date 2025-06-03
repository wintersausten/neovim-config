require "user.launch"
require "user.options"
require "user.keymaps"
require "user.autocmds"
spec "user.colorscheme"
spec "user.devicons"
spec "user.treesitter"
spec "user.mason"
spec "user.schemastore"
spec "user.lspconfig"
spec "user.cmp"
spec "user.conform"
spec "user.nvim-lint"
spec "user.telescope"
spec "user.gitsigns" -- TODO review configs, get notifications color working for whats commited/not
spec "user.lualine" -- TODO Migrate to mini 
spec "user.navic"
spec "user.indentline" -- TODO Migrate to mini 
spec "user.breadcrumbs"
spec "user.oil"
spec "user.dap"
spec "user.harpoon"

spec "user.mini.cursorword"
spec "user.mini.clue"
spec "user.mini.comment"

-- Need to go through these still
spec "user.autopairs" -- TODO migrate to mini
spec "user.neotest" 
spec "user.alpha" -- TODO Migrate to mini
spec "user.project"
spec "user.toggleterm"
spec "user.marks"
-- TODO git handling?
-- TODO mini.ai
require "user.lazy"
