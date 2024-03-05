local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm({select = false}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-p>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})


require('lspconfig').tsserver.setup({})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').pyright.setup({})
require('lspconfig').gopls.setup({})
require('lspconfig').bashls.setup({})
require('lspconfig').jsonls.setup({})
require('lspconfig').yamlls.setup({})
require('lspconfig').vimls.setup({})
require('lspconfig').html.setup({})
require('lspconfig').cssls.setup({})
require('lspconfig').cssmodules_ls.setup({})
require('lspconfig').svelte.setup({})
require('lspconfig').vuels.setup({})
require('lspconfig').angularls.setup({})
require('lspconfig').clangd.setup({})
require('lspconfig').cmake.setup({})
require('lspconfig').dockerls.setup({})
require('lspconfig').csharp_ls.setup({})
require('lspconfig').sqlls.setup({})
require('lspconfig').htmx.setup({})
require('lspconfig').tailwindcss.setup({})
require('lspconfig').vuels.setup({})
require('lspconfig').svelte.setup({})
require('lspconfig').solidity.setup({})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').postgres_lsp.setup({})
require('lspconfig').markdown_oxide.setup({})
require('lspconfig').luau_lsp.setup({})
require('lspconfig').jsonls.setup({})
