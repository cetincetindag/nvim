local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-f>h", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-f>j", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-f>k", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-f>l", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-f>p", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-f>n", function() harpoon:list():next() end)
