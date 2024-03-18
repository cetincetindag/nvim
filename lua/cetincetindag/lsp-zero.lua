local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require'lspconfig'.tsserver.setup{}
require'lspconfig'.cssls.setup{}    
require'lspconfig'.html.setup{}    
require'lspconfig'.jsonls.setup{}    
require'lspconfig'.pyright.setup{}
require'lspconfig'.prismals.setup{}
require'lspconfig'.svelte.setup{}
require'lspconfig'.tailwindcss.setup{}
require'lspconfig'.vuels.setup{}





