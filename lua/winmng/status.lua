local config = require("winmng.config")

local M = {}

M.backup = function(wins)
  local opts = { glob = {}, win = {} }

  if vim.o.cmdheight < 1 then
    opts.glob['cmdheight'] = vim.o['cmdheight']
  end

  if vim.o.laststatus ~= 2 then
    opts.glob['laststatus'] = vim.o['laststatus']
  end

  for _, win in pairs(wins) do
    opts.win[win] = {}

    opts.win[win]['statusline'] = vim.wo[win]['winblend']
    opts.win[win]['winhl'] = vim.wo[win]['winhl']
  end

  return opts
end

M.init = function(wins)
  vim.o.cmdheight = 1
  vim.o.laststatus = 2

  for _, win in pairs(wins) do
    vim.wo[win]['statusline'] = '%=%='
    vim.wo[win]['winhl'] = 'StatusLine:Winmng,StatusLineNC:WinmngNC'
  end
end

M.open = function(wins)
  for i, win in ipairs(wins) do
    local char = config.values.chars:sub(i, i)

    vim.wo[win]['statusline'] = '%=' .. char .. '%='
  end
end

M.restore = function(opts)
  for opt, opt_val in pairs(opts.glob) do
    vim.o[opt] = opt_val
  end

  for win, win_opts in pairs(opts.win) do
    for opt, val in pairs(win_opts) do
      vim.wo[win][opt] = val
    end
  end
end

return M
