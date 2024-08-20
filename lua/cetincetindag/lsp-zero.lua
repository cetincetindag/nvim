local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

local cmp = require('cmp')
cmp.setup({
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }
})

require 'lspconfig'.clangd.setup {}
require 'lspconfig'.cmake.setup {}
require 'lspconfig'.tsserver.setup {}
require 'lspconfig'.html.setup {}
require 'lspconfig'.jsonls.setup {}
require 'lspconfig'.pyright.setup {}
require 'lspconfig'.prismals.setup {}
require 'lspconfig'.svelte.setup {}
require 'lspconfig'.tailwindcss.setup {}
require 'lspconfig'.vuels.setup {}
require 'lspconfig'.gopls.setup {}
require 'lspconfig'.lua_ls.setup {}
require 'lspconfig'.yamlls.setup {}
require 'lspconfig'.dockerls.setup {}
require 'lspconfig'.rust_analyzer.setup {}
require 'lspconfig'.rls.setup {}
