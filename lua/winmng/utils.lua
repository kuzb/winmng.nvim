local config = require("winmng.config")

local M = {}

M.get_input = function()
  local ok, char = pcall(vim.fn.getchar)

  return ok and vim.fn.nr2char(char) or nil
end

M.is_ignored = function(win_id)
  local buf = vim.api.nvim_win_get_buf(win_id)

  if vim.tbl_contains(config.values.ignored.wintypes, vim.fn.win_gettype(win_id)) then
    return true
  end

  if vim.tbl_contains(config.values.ignored.buftypes, vim.bo[buf].buftype) then
    return true
  end

  if vim.tbl_contains(config.values.ignored.filetypes, vim.bo[buf].filetype) then
    return true
  end

  return false
end

M.list_wins = function()
  local tab_wins = vim.api.nvim_tabpage_list_wins(vim.api.nvim_get_current_tabpage())
  local current_win_id = vim.api.nvim_get_current_win()

  local filtered = vim.tbl_filter(function(win)
    return not M.is_ignored(win) and current_win_id ~= win
  end, tab_wins)

  table.sort(filtered, function(w1, w2)
    return vim.api.nvim_win_get_number(w1) < vim.api.nvim_win_get_number(w2)
  end)

  return tab_wins, filtered
end

return M
