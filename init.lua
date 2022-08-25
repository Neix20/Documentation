require('packer_init')

require('core/options')
require('core/keymaps')
require('core/autocmds')
require('core/tabline')
-- require('core/statusline')

require('plugins/alpha-nvim')
require('plugins/nvim-cmp')
require('plugins/nvim-lspconfig')
require('plugins/nvim-treesitter')
require('plugins/nvim-tree')

require('plugins/lualine')

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-- Set Background To Dark
opt.background = 'dark'

-- Set Colorscheme to NeixOne
vim.cmd([[
    colorscheme NeixOne
]])

-- Colors
vim.cmd([[
    hi ActiveTab guibg=#98c379 guifg=#000000 ctermbg=114 ctermfg=235
    hi InactiveTab guibg=#000000 guifg=#ffffff ctermbg=236 ctermfg=145
    hi TabBuffer guibg=#282c34 guifg=#282c34 ctermbg=236 ctermfg=114
]])

-- Set Tab Line
vim.cmd([[
    set tabline=%!MyTabLine()
]])

