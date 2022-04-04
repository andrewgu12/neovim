local map = vim.api.nvim_set_keymap
local g = vim.g

-- silent & non recursive
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }


-- map space to leader key
map('n', '<Space>', '', {})
g.mapleader = ' '
map('n', '<leader>w', '<c-w>', { noremap = true })

-- use f-d to escape insert mode
map('i', 'fd', '<Esc>', default_opts)

-- get out of terminal with jk
map("t", "jk", "<C-\\><C-n>", default_opts)

-- Center search results
map("n", "n", "nzz", default_opts)
map("n", "N", "Nzz", default_opts)

-- Better indent
map("v", "<", "<gv", default_opts)
map("v", ">", ">gv", default_opts)

-- Cancel search highlighting with ESC
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

