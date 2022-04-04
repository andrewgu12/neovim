local M = {}
local cmd = vim.cmd
local opt = vim.opt

function M.setup()
  local indentblankline = require("indent_blankline")

  opt.list = true
  opt.listchars = {
    space = "⋅",
    eol = "↴"
  }

  local conf = {
    show_end_of_line = true,
    space_char_blankline = " ",
  }

  indentblankline.setup(conf)

end

return M
