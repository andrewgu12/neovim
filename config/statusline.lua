local function status_line()
  -- displays the mode we're currently in
  local mode = "%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}"
  -- displays the filename
  local file_name = "%-.16t"
  -- buffer number next to the filename
  local buf_nr = "[%n]"
  -- show whether or not the file is modified
  local modified = " %-m"
  local filetype = " %y"
  local right_align = "%="
  local line_no = "%10([%l/%L%)]"
  local pct_thru_file = "%5p%%"

  return string.format("%s%s%s%s%s%s%s%s", mode, file_name, buf_nr, modified, filetype, right_aline, line_no, pct_thru_file)
end

vim.opt.statusline = status_line()
