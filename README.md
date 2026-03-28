# winmng.nvim

Easily pick or swap windows in Neovim

## Features

- Jump to picked window

![pick_opti](https://github.com/kuzb/winmng.nvim/assets/25966162/77afba0e-b604-473d-8fbd-e8bfbf0923aa)

- Swap current window with picked window and jump to it

![swap_opti](https://github.com/kuzb/winmng.nvim/assets/25966162/439060ac-28ea-4159-b68a-bd824c27e39b)

## Install

Using packer.nvim

```lua
use {
  'kuzb/winmng.nvim',
  config = function()
    require('winmng').setup()

     vim.keymap.set('n', '<leader>wp', require('winmng').pick, {
       desc = 'Winmng: Pick window',
     })
     vim.keymap.set('n', '<leader>ws', require('winmng').swap, {
       desc = 'Winmng: Swap window',
     })
  end
}
```
