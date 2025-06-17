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

return require('lazy').setup({
  -- UI and utilities
  {
    "folke/trouble.nvim",
    branch = "main",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
    },
    opts = {},
  },

  -- Telescope for fuzzy finding
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })
    end,
  },

  -- Auto pairs for brackets, quotes, etc.
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
  },

  -- Theme
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme kanagawa]])
    end,
  },

  -- Treesitter for better syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          "c", "lua", "vim", "vimdoc", "query", "javascript", 
          "typescript", "tsx", "json", "python", "rust", "markdown", 
          "bash", "cpp", "html", "css"
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },
  
  -- Treesitter playground for inspecting syntax tree
  'nvim-treesitter/playground',

  -- Harpoon for quick file navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
    end,
  },

  -- Git integration and utilities
  'mbbill/undotree',
  'tpope/vim-fugitive',

  -- Automatic tag closing for HTML, JSX, etc.
  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },

  -- Emmet support for HTML/CSS
  {
    'mattn/emmet-vim',
    ft = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    config = function()
      vim.g.user_emmet_leader_key = '<C-y>'
    end
  },

  -- LSP and autocompletion setup
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  },

  -- Formatting and linting
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettierd.with({
            filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact", "json", "css", "scss", "html" }
          }),
        },
      })
    end
  },

  -- Better UI for LSP related features
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          enable = false,
          enable_in_insert = false,
          sign = true,
          sign_priority = 40,
          virtual_text = true,
        },
        symbol_in_winbar = {
          enable = true,
          separator = " › ",
          hide_keyword = true,
          show_file = true,
          folder_level = 2,
        },
      })
      
      -- Key mappings for Lspsaga
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
      vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
      vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
      vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>")
    end,
    dependencies = {
      {"nvim-tree/nvim-web-devicons"},
      {"nvim-treesitter/nvim-treesitter"}
    }
  },

  -- UI components
  'nvim-tree/nvim-web-devicons',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'kanagawa',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      })
    end
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    }
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      
      -- Auto open dap ui when debugging starts
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      
      -- Auto close dap ui when debugging ends
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"},
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {"codelldb"},
        automatic_installation = true,
        handlers = {},
      })
    end
  },
})
