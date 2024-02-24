local M = {}

local default = {
  chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
  ui = {
    fg = "#C0CAF5",
    bg = "#16161E",
    bold = true,
  },
  ignored = {
    filetypes = {
      "diff",
      "git",
      "gitcommit",
      "gitrebase",
      "help",
      "log",
    },
    buftypes = {
      "acwrite",
      "help",
      "nofile",
      "nowrite",
      "prompt",
      "quickfix",
      "terminal",
    },
    wintypes = {
      "autocmd",
      "command",
      "loclist",
      "popup",
      "preview",
      "quickfix",
      "unknown",
    }
  }
}

M.setup = function(user_config)
  M.values = vim.tbl_deep_extend("force", default, user_config or {})

  vim.api.nvim_set_hl(0, 'Winmng', {
    fg = M.values.ui.bg,
    bg = M.values.ui.bg,
    bold = M.values.ui.bold,
  })

  vim.api.nvim_set_hl(0, 'WinmngNC', {
    fg = M.values.ui.fg,
    bg = M.values.ui.bg,
    bold = M.values.ui.bold,
  })
end

return M
