# winmng.nvim

Easily pick or swap windows in Neovim

## Features

* Jump to picked window 

![pick_opti](https://github.com/kuzb/winmng.nvim/assets/25966162/77afba0e-b604-473d-8fbd-e8bfbf0923aa)

* Swap current window with picked window and jump to it
  
![swap_opti](https://github.com/kuzb/winmng.nvim/assets/25966162/439060ac-28ea-4159-b68a-bd824c27e39b)

## Install

Using packer.nvim

```lua
use { 
  "kuzb/winmng.nvim",
  config = function()
    require("winmng").setup()

    globals.nnoremap("<space>wp", function()
      require("winmng").pick()
    end, { desc = "Pick Window" })

    globals.nnoremap("<space>ws", function()
      require("winmng").swap()
    end, { desc = "Swap Window" })
  end
}
```
