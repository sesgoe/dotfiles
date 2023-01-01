-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

------------------------
-- General Keymaps
------------------------

keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Shift J in visual mode moves line up
keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Shift K in visual mode moves line down

keymap.set("n", "J", "mzJ`z") -- When merging line up, keep cursor in same spot
keymap.set("n", "<C-d>", "<C-d>zz") -- Keep cursor in middle when going page down
keymap.set("n", "<C-u>", "<C-u>zz") -- Keep cursor in middle when going page up
keymap.set("n", "n", "nzzzv") -- Keep cursor in middle when moving through results with 'n'
keymap.set("n", "N", "Nzzzv") -- Keep cursor in middle when moving through results backwards with 'N'

-- greatest remap ever
keymap.set("x", "<leader>p", [["_dP]]) -- ??

-- next greatest remap ever : asbjornHaland
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

keymap.set({ "n", "v" }, "<leader>d", [["_d]])

keymap.set("n", "Q", "<nop>") -- Q is dumb, unbind it
-- keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap.set("n", "<leader>f", vim.lsp.buf.format) -- LSP formatter

keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

keymap.set('n', '<leader>sv', '<C-w>v') -- split window vertically
keymap.set('n', '<leader>sh', '<C-w>s') -- split window horizontally
keymap.set('n', '<leader>se', '<C-w>=') -- make split windows equal width/height
keymap.set('n', '<leader>sx', ':close<CR>') -- close current split window

------------------------
-- Plugin Keymaps
------------------------

-- nvim-tree
keymap.set('n', '<leader>e', [[:NvimTreeToggle<CR>]])
keymap.set('n', '<leader>t', [[:NvimTreeFocus<CR>]])

-- auto-format files on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })]]
