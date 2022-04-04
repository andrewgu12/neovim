local globalOptions = vim.o
local windowOptions = vim.wo
local g = vim.g
local api = vim.api

-- file spacing & indents
globalOptions.expandtab = true
globalOptions.tabstop = 2
globalOptions.shiftwidth = 2
globalOptions.smartindent = true
vim.cmd('filetype indent on')

-- color scheme
vim.cmd('colorscheme onedark')
globalOptions.termguicolors = true

-- actually copy to system clipboard
globalOptions.clipboard = 'unnamedplus'

-- syntax checking
globalOptions.syntax = 'true'

-- searching options
globalOptions.smartcase = true
globalOptions.ignorecase = true
globalOptions.incsearch = true
globalOptions.hlsearch = true

-- number lines
windowOptions.number = true
windowOptions.cursorline = true

-- delete trailing whitespaces on save
api.nvim_command('autocmd BufWritePre * :%s/\\s\\+$//e')

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- time in milliseconds to wait for a mapped sequence to complete
globalOptions.timeoutlen = 300
