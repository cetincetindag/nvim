vim.opt.nu = false
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 8
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.signcolumn = "no"
vim.opt.cursorline = true
vim.opt.cursorcolumn = false

vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.api.nvim_command('autocmd TermOpen * startinsert')
vim.api.nvim_command('autocmd TermOpen * setlocal nonumber norelativenumber')
