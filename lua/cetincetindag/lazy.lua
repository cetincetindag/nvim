local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


return require('lazy').setup {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        requires = { {'nvim-lua/plenary.nvim'} }
    },
    {
        'rebelot/kanagawa.nvim',
        as = 'kanagawa',
        config = function()
            vim.cmd('colorscheme kanagawa-dragon')
        end
    },
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/playground',
    'nvim-lua/plenary.nvim',
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    },
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'github/copilot.vim',
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'kyazdani42/nvim-web-devicons',

    {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    { 'echasnovski/mini.pairs', version = false },
    { 'nvim-tree/nvim-tree.lua', 
        version = "*",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        lazy = false
    }
}

   
