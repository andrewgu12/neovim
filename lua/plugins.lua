return {
    { 
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup {
                style = 'deep'
            }
            require('onedark').load()
        end,
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                              , branch = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require'nvim-web-devicons'.setup {
                -- your personnal icons can go here (to override)
                -- you can specify color or cterm_color instead of specifying both of them
                -- DevIcon will be appended to `name`
                override = {
                    zsh = {
                        icon = "",
                        color = "#428850",
                        cterm_color = "65",
                        name = "Zsh"
                    }
                };
                -- globally enable different highlight colors per icon (default to true)
                -- if set to false all icons will have the default icon's color
                color_icons = true;
                -- globally enable default icons (default to false)
                -- will get overriden by `get_icons` option
                default = true;
                -- globally enable "strict" selection of icons - icon will be looked up in
                -- different tables, first by filename, and if not found by extension; this
                -- prevents cases when file doesn't have any extension but still gets some icon
                -- because its name happened to match some extension (default to false)
                strict = true;
                -- same as `override` but specifically for overrides by filename
                -- takes effect when `strict` is true
                override_by_filename = {
                    [".gitignore"] = {
                        icon = "",
                        color = "#f1502f",
                        name = "Gitignore"
                    }
                };
                -- same as `override` but specifically for overrides by extension
                -- takes effect when `strict` is true
                override_by_extension = {
                    ["log"] = {
                        icon = "",
                        color = "#81e043",
                        name = "Log"
                    }
                };
            }
        end
    },-- not strictly required, but recommended
    {
        'nvim-treesitter/nvim-treesitter', 
        build = ':TSUpdate',
    },
    'mbbill/undotree',
    --'tpope/vim-fugitive',
    'lewis6991/gitsigns.nvim',

	-- lsp stuff
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
			'williamboman/mason.nvim',
			build = function()
				pcall(vim.cmd, 'MasonUpdate')
			end,
		},
		{'williamboman/mason-lspconfig.nvim'}, -- Optional

	      -- Autocompletion
	      {'hrsh7th/nvim-cmp'},     -- Required
	      {'hrsh7th/cmp-nvim-lsp'}, -- Required
	      {'L3MON4D3/LuaSnip'},     -- Required
	    }
	  },

      'jose-elias-alvarez/null-ls.nvim',
      {
          "nvim-neo-tree/neo-tree.nvim",
          branch = "v2.x",
          dependencies = { 
              { "nvim-lua/plenary.nvim" },
              { "nvim-tree/nvim-web-devicons" },-- not strictly required, but recommended
              { "MunifTanjim/nui.nvim"},
          }
      },
      'nvim-lualine/lualine.nvim',
  }
