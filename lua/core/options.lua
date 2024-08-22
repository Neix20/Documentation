-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
opt.swapfile = false                  -- Don't use swapfile
opt.encoding = 'utf-8'
opt.hidden = true
opt.wildmode = 'longest,list'
opt.cursorline = true
opt.ttyfast = true
opt.backup = false
opt.writebackup = false

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.termguicolors = true    -- Enable 24-bit RGB colors
vim.cmd([[
    set t_Co=256
]])
opt.foldmethod = 'indent'   -- Enable folding (default 'foldmarker')
opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
opt.cmdheight = 2
opt.updatetime = 300
opt.tags = './tags,tags'
opt.number = true           -- Show line number
opt.laststatus=2            -- Set global statusline
opt.showmatch = true        -- Highlight matching parenthesis
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.linebreak = true        -- Wrap on word boundary

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 4          -- Shift 4 spaces when tab
opt.tabstop = 4             -- 1 tab == 4 spaces
opt.softtabstop = 4
opt.autoindent = true      -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 100           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 700        -- ms to wait for trigger an event
