-- This is my config that is constantly updated according to my preferences.
-- (which change a lot)
-- Feel free to use and modify to your liking :)
-- ~~ cetin cetindag ~~
--
-- leader mapping
vim.g.mapleader = " "
vim.g.maplocalleader = "//"
--

-- source cfg
vim.keymap.set("n", "<leader><CR>", function()
  vim.cmd("so")
end)
--
-- netrw (is disabled but anyway)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move line up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
--
-- quit
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>Q", ":q!<CR>")
--
-- nvim tree
vim.keymap.set('n', '<leader>e', function()
  local api = require("nvim-tree.api")
  if api.tree.is_visible() then
    api.tree.close()
  else
    api.tree.open()
  end
end, { noremap = true, silent = true })

--
-- save and format
vim.keymap.set("n", "<leader>w", ":w<CR><cmd>lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })
--
-- buffer delete
vim.keymap.set("n", "<leader>bd", ":bd!<CR>")
--
-- half page center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
--
-- append line but cursor stays in the same pos.
vim.keymap.set("n", "J", "mzJ`z")
--
-- when searching for iterations, cursor stays in the same pos.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
--
-- copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
--
-- paste same thing without replacing the clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])
--
-- search and replace macro
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--
-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
--
-- exit terminal mode
vim.keymap.set("t", "<C-x>", "<C-\\><C-n><C-w>h")

-- telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})

-- trouble
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", { noremap = true, silent = true })

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Map jj to escape insert mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Map Escape Escape to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = "Exit terminal mode", noremap = true, silent = true })
