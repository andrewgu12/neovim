local M = {}

function M.setup()
	-- Indicate first time installation
	local packer_boostrap = false


	-- packer.nvim configuration
	local conf = {
    profile = {
      enable = true,
      threshold = 1,
    },
		display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end
		}
	}

  -- check if packer.nvim is installed
  -- Run PackerCompile if there are any changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end


  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

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
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require("config.whichkey").setup()
       end,
    }

    use {
      "windwp/nvim-autopairs",
      wants = "nvim-treesitter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("nvim-autopairs").setup()
      end
    }

    use {
       "lukas-reineke/indent-blankline.nvim",
       config = function()
         require("config.indentblankline").setup()
       end
    }

    use {
      'terrortylor/nvim-comment',
      config = function()
        require('nvim_comment').setup()
      end
    }

    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufRead",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
      },
    }

    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = function()
       require("config.lualine").setup()
      end,
      requires = { "nvim-web-devicons" },
    }


    use {
     "ibhagwan/fzf-lua",
      requires = { "kyazdani42/nvim-web-devicons" },
    }

    use {
      "kyazdani42/nvim-tree.lua",
       requires = {
         "kyazdani42/nvim-web-devicons",
       },
       cmd = { "NvimTreeToggle", "NvimTreeClose" },
       config = function()
         require("config.nvimtree").setup()
       end,
    }

    -- Buffer line
    use {
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      wants = "nvim-web-devicons",
      config = function()
        require("config.bufferline").setup()
      end,
    }

    use {
      "phaazon/hop.nvim",
      cmd = { "HopWord", "HopChar1" },
      config = function()
        require("hop").setup {}
      end,
    }
    use {
      "ggandor/lightspeed.nvim",
      keys = { "s", "S", "f", "F", "t", "T" },
      config = function()
        require("lightspeed").setup {}
      end,
    }

    -- Completion
    use {
      "ms-jpq/coq_nvim",
      branch = "coq",
      event = "InsertEnter",
      opt = true,
      run = ":COQdeps",
      config = function()
        require("config.coq").setup()
      end,
      requires = {
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        { "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
      },
      disable = false,
    }

    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-calc",
        "f3fora/cmp-spell",
        "hrsh7th/cmp-emoji",
        {
          "L3MON4D3/LuaSnip",
          wants = "friendly-snippets",
          config = function()
            require("config.luasnip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
        disable = false,
      },
    }

    -- Auto tag
    use {
      "windwp/nvim-ts-autotag",
      wants = "nvim-treesitter",
      event = "InsertEnter",
      config = function()
        require("nvim-ts-autotag").setup { enable = true }
      end,
    }

    -- End wise
    use {
      "RRethy/nvim-treesitter-endwise",
      wants = "nvim-treesitter",
      event = "InsertEnter",
    }

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      wants = { "nvim-lsp-installer" },
      config = function()
        require("config.lsp.init").setup()
      end,
      requires = {
        "williamboman/nvim-lsp-installer",
      },
    }

    if packer_bootstrap then
      print "Restart neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
