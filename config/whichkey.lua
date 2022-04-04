local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = 'single',
      position = 'bottom'
    }
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    z = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },
    w = {
      name = "Window",
      ["<Left>"] = { "", "Move to left" },
      ["<Right>"] = { "", "Move to right" },
      ["<Up>"] = { "", "Move to up" },
      ["<Down>"] = { "", "Move to down" },
    },
    s = {
      name = "Find",
      p = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
      b = { "<cmd>FzfLua buffers<cr>", "Buffers" },
      o = { "<cmd>FzfLua oldfiles<cr>", "Old files" },
      g = { "<cmd>FzfLua live_grep<cr>", "Live grep" },
      c = { "<cmd>FzfLua commands<cr>", "Commands" },
      t = {"<cmd>NvimTreeToggle<cr>", "Explorer"}
    },
   }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
