local config = require("winmng.config")
local utils = require("winmng.utils")
local status = require("winmng.status")

local escape = 27

local M = {}

local function pick(win)
  vim.api.nvim_set_current_win(win)
end

local function swap(w1, w2)
  local b1 = vim.api.nvim_win_get_buf(w1)
  local c1 = vim.api.nvim_win_get_cursor(w1)
  local b2 = vim.api.nvim_win_get_buf(w2)
  local c2 = vim.api.nvim_win_get_cursor(w2)

  vim.api.nvim_win_set_buf(w2, b1)
  vim.api.nvim_win_set_buf(w1, b2)

  vim.api.nvim_win_set_cursor(w2, c1)
  vim.api.nvim_win_set_cursor(w1, c2)

  vim.api.nvim_set_current_win(w2)
end

local function prompt()
  local all, filtered = utils.list_wins()

  if #filtered < 1 then
    return nil
  end

  if #filtered > #config.values.chars then
    vim.notify(
      string.format("winmng: There aren't enough characters to index %d as many windows", #filtered),
      vim.log.levels.WARN
    )
    return nil
  end

  local opts = status.backup(all)

  status.init(all)

  status.open(filtered)

  vim.cmd.redraw()

  local char = utils.get_input()

  status.restore(opts)

  if not char or char == escape then
    return
  end

  for i, win in ipairs(filtered) do
    if string.lower(config.values.chars:sub(i, i)) == string.lower(char) then
      return win
    end
  end

  return nil
end

function M.setup(user_config)
  config.setup(user_config)
end

function M.pick()
  if not config.values then
    vim.notify("winmng: setup is not called", vim.log.levels.ERROR)
    return
  end

  local win = prompt()

  if win then
    pick(win)
  end
end

function M.swap()
  if not config.values then
    vim.notify("winmng: setup is not called", vim.log.levels.ERROR)
    return
  end

  if utils.is_ignored(vim.api.nvim_get_current_win()) then
    return
  end

  local win = prompt()

  if win then
    swap(vim.api.nvim_get_current_win(), win)
  end
end

return M
