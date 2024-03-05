vim.cmd[[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use({
        'rebelot/kanagawa.nvim',
        as = 'kanagawa',
        config = function()
            vim.cmd('colorscheme kanagawa-dragon')
        end
    })

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('nvim-treesitter/playground')
    use "nvim-lua/plenary.nvim" 

    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    }

    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use("github/copilot.vim")
    use("neovim/nvim-lspconfig")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    if packer_bootstrap then
        require('packer').sync()
    end
end)


