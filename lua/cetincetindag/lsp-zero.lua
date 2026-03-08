local lsp_zero = require('lsp-zero')

-- Configure default keymaps and custom ones when an LSP attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local bufnr = event.buf
    local opts = { buffer = bufnr, noremap = true, silent = true }

    lsp_zero.default_keymaps({ buffer = bufnr })

    vim.keymap.set('n', 'gp', "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.keymap.set('n', 'gP', "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.keymap.set('n', 'gi', "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.keymap.set('n', '<leader>ca', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.keymap.set('n', '<leader>rn', "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  end,
})

-- Set up Mason for easy LSP server installation
require('mason').setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require('mason-lspconfig').setup({
  ensure_installed = {
    'clangd',
    'cmake',
    'ts_ls',
    'html',
    'cssls',
    'jsonls',
    'pyright',
    'tailwindcss',
    'lua_ls',
    'yamlls',
    'dockerls',
    'rust_analyzer',
    'taplo',
    'vimls',
  },
})

-- Setup Mason Tool Installer to automatically install formatters and linters
require('mason-tool-installer').setup({
  ensure_installed = {
    'prettierd', -- Formatter for TypeScript, JavaScript, etc.
    'eslint_d',  -- Linter for TypeScript, JavaScript
  },
  auto_update = true,
  run_on_start = true,
})

-- Configure completion
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  },
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        buffer = 'Ω',
        path = '🖫',
      }
      item.menu = menu_icon[entry.source.name] or entry.source.name
      return item
    end,
  },
})

-- LSP Configurations (nvim 0.11+ API)

vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--offset-encoding=utf-16",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
  root_dir = function(bufnr)
    return vim.fs.root(bufnr, { 'compile_commands.json', 'compile_flags.txt', '.git' })
  end,
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.config('vimls', {
  init_options = {
    diagnostic = {
      enable = true,
    },
    indexes = {
      count = 3,
      gap = 100,
      projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
      runtimepath = true,
    },
    iskeyword = "@,48-57,_,192-255,-#",
    suggest = {
      fromRuntimepath = true,
      fromVimruntime = true,
    },
  },
})

vim.lsp.config('sourcekit', {})

vim.lsp.config('ts_ls', {
  root_dir = function(bufnr)
    return vim.fs.root(bufnr, { 'package.json', 'tsconfig.json', '.git' })
  end,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      format = { enable = true },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      format = { enable = true },
    },
  },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = true
  end,
})

vim.lsp.config('html', {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  filetypes = { "html", "templ" },
  settings = {
    html = {
      format = {
        templating = true,
        wrapLineLength = 120,
        wrapAttributes = 'auto',
      },
      hover = {
        documentation = true,
        references = true,
      },
    },
  },
})

vim.lsp.config('cssls', {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  settings = {
    css  = { validate = true, lint = { unknownAtRules = "ignore" } },
    scss = { validate = true, lint = { unknownAtRules = "ignore" } },
    less = { validate = true, lint = { unknownAtRules = "ignore" } },
  },
})

vim.lsp.config('tailwindcss', {
  filetypes = {
    "html", "css", "scss", "javascript", "javascriptreact",
    "typescript", "typescriptreact", "vue", "svelte", "astro", "templ",
  },
  init_options = {
    userLanguages = {
      eelixir = "html-eex",
      eruby = "erb",
      templ = "html",
    },
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
      experimental = {
        classRegex = {
          "tw`([^`]*)",
          { "clsx\\(([^)]*)\\)",       "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "classnames\\(([^)]*)\\)", "'([^']*)'" },
          { "cva\\(([^)]*)\\)",        "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cn\\(([^)]*)\\)",         "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
    },
  },
  root_dir = function(bufnr)
    return vim.fs.root(bufnr, {
      'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts',
      'postcss.config.js',  'postcss.config.cjs',  'postcss.config.mjs',  'postcss.config.ts',
      'package.json', 'node_modules', '.git',
    })
  end,
})

vim.lsp.enable({
  'clangd', 'lua_ls', 'vimls', 'sourcekit',
  'ts_ls', 'html', 'cssls', 'tailwindcss',
})

-- Setup format on save for specific file types
local format_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Create an autocommand for formatting on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_augroup,
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.json", "*.html", "*.css" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Autocmd for better Tailwind CSS experience
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.html", "*.jsx", "*.tsx", "*.vue", "*.svelte" },
  callback = function()
    -- Enable word-based completion for class attributes
    vim.opt_local.iskeyword:append("-")
  end,
})
