local globalOptions = vim.o
local windowOptions = vim.wo
local bufferOptions = vim.bo
local map = vim.api.nvim_set_keymap
local g = vim.g

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use "siduck76/nvim-base16.lua"
  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require('colorizer').setup()
      vim.cmd("ColorizerReloadAllBuffers")
    end
  }
  use "kyazdani42/nvim-web-devicons"
  use "joshdick/onedark.vim"

  use {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = function()
      local ts_config = require("nvim-treesitter.configs")

      ts_config.setup {
        ensure_installed = 'maintained',
        indent = {
          enable = false
        },
        autopairs = {
          enable = true
        },
        highlight = {
          enable = true,
          use_languagetree = true
        }
      }
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'},
    {'nvim-lua/plenary.nvim'}}
  }

  -- use {
  --   'windwp/nvim-autopairs',
  --   config = function()
  --     require('nvim-autopairs').setup()
  --   end
  -- }
  use {
    'hoob3rt/lualine.nvim',
    requires ={'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup {
        options = {
          theme = 'onedark'
        }
      }
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  use "lukas-reineke/indent-blankline.nvim"

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      "kyazdani42/nvim-web-devicons"
    },
    config = function()
      vim.g.nvim_tree_indent_markers = 1
      vim.g.nvim_tree_highlight_opened_files = 1
      require('nvim-tree').setup {
        open_on_setup = true,
        update_cwd = true,
        open_on_tab = true
      }
    end
  }

  use {
    'romgrk/barbar.nvim',
    requires = {
      "kyazdani42/nvim-web-devicons"
    },
  }

  use {
    'sbdchd/neoformat',
    config = function()
      vim.g.neoformat_enabled_javascript = {'prettier'}
      vim.g.neoformat_enabled_json ={'prettier'}
      vim.g.neoformat_enabled_html = {'prettier'}
      vim.g.neoformat_enabled_typescript = {'prettier', 'tslint'}
    end
  }

  -- lsp & autocomplete
  use 'neovim/nvim-lspconfig'
  use  'williamboman/nvim-lsp-installer'

  use {
    'hrsh7th/nvim-compe',
    config = function()
      require('compe').setup {
        enabled = true,
        autocomplete = true,
        preselect = 'enable',
        min_length = 1,
        throttle_time = 80,
        source_timeout = 200,
        resolve_timeout = 800,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = false,

        source = {
          path = true,
          buffer = true,
          nvim_lsp = true,
          nvim_lua = true,
          treesitter = true
        }
      }
    end
  }

  use {
    "terrortylor/nvim-comment",
    config = function()
      require('nvim_comment').setup()
    end
  }
end
)

vim.o.completeopt = "menuone,noselect"
globalOptions.clipboard = 'unnamedplus'


-- syntax checking
globalOptions.syntax = 'true'


-- color scheme
vim.cmd('colorscheme onedark')


-- searching options
globalOptions.smartcase = true
globalOptions.ignorecase = true
globalOptions.incsearch = true
globalOptions.hlsearch = true

-- colors
globalOptions.termguicolors = true

-- number lines
windowOptions.number = true
windowOptions.cursorline = true

-- map space to leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '
map('n', '<leader>w', '<c-w>', {noremap = true})

-- use f-d to escape insert mode
map('i', 'fd', '<Esc>', {})

-- default spacing
globalOptions.expandtab = true
globalOptions.tabstop = 2
globalOptions.shiftwidth = 2
globalOptions.smartindent = true
vim.cmd('filetype on')

-- reindent file
map('n', 'ff', ':Neoformat<CR>', {})

-- telescope find/search
map('n', '<Leader><Leader>', '<cmd>Telescope live_grep<CR>', {})
map('n', '<Leader>sp', '<cmd>Telescope find_files<CR>', {})


-- delete trailing white spaces on save
vim.api.nvim_command("autocmd BufWritePre * :%s/\\s\\+$//e")

-- default to split below and to the right
globalOptions.splitbelow = true
globalOptions.splitright = true


--  term bottom
map("n", "<C-x>", [[<Cmd> split term://zsh | resize 20 <CR>]], {})
-- get out of terminal with jk
map("t", "jk", "<C-\\><C-n>", {})

-- compe shenanigans
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end


map('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})


-- Commenter Keybinding
map("n", "<leader>/", ":CommentToggle<CR>", {})
map("v", "<leader>/", ":CommentToggle<CR>", {})



local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)

	    local on_attach = function(client, bufnr)
	      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	      --Enable completion triggered by <c-x><c-o>
	      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	      -- Mappings.
	      local opts = { noremap=true, silent=true }

	      -- See `:help vim.lsp.*` for documentation on any of the below functions
	      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	      buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	      buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	      buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	      buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	      buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	      buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	      buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	      buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	      buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	      buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	      buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	    end

    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
        server:setup {
          on_attach = on_attach,
          root_dir = vim.loop.cwd,
          flags = {
            debounce_text_changes = 150,
          }
        }
  end)


globalOptions.inccommand = 'nosplit'
