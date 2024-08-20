vim.g.mapleader = " "
vim.g.maplocalleader = "//"
-- netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- move line up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- quit and save
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>Q", ":q!<CR>")
-- save and format
vim.keymap.set("n", "<leader>w", ":w<CR><cmd>LspZeroFormat<CR><esc>")
-- buffer delete
vim.keymap.set("n", "<leader>bd", ":bd!<CR>")
-- half page center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- append line but cursor stays in the same pos.
vim.keymap.set("n", "J", "mzJ`z")
-- when searching for iterations, cursor stays in the same pos.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- paste same thing without replacing the clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])
-- search and replace macro
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- source
vim.keymap.set("n", "<leader><CR>", function()
  vim.cmd("so")
end)
-- navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
-- nvim-tree toggle
vim.keymap.set("n", "<leader>e", function()
  vim.cmd("NvimTreeFocus")
end)
--lsp zero format
vim.keymap.set("n", "<leader>fa", "<cmd>LspZeroFormat<CR><esc>")
--copilot disable and enable
vim.keymap.set("n", "<leader>cpd", "<cmd>Copilot disable<CR><cmd>LspRestart<CR>")
vim.keymap.set("n", "<leader>cpe", "<cmd>Copilot enable<CR><cmd>LspRestart<CR>")
-- exit terminal mode
vim.keymap.set("t", "<C-x>", "<C-\\><C-n><C-w>h")
