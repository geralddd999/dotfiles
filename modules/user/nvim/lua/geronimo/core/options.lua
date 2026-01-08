vim.cmd("let g:netrw_banner = 0")
-- Block cursor
vim.opt.guicursor = ""
--Absolute line numbers
vim.opt.nu = true
-- Line relative numbers
vim.opt.relativenumber = true

-- Tabs | formatting
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true

-- save file and tmp backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true --allows to revert changes even after saving

vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI and visuals
vim.opt.termguicolors = true
vim.opt.background = "dark"
-- padding
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.backspace = {"start", "eol", "indent"}

vim.opt.splitright = true --vertical
vim.opt.splitbelow = true --horizontal

--Personal preference
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.opt.clipboard:append("unnamedplus")
vim.opt.hlsearch = true

vim.opt.mouse = "a"
vim.g.editorconfig = true



