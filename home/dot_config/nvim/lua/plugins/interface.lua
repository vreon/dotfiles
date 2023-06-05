return {
  -- highlight color codes
  {
    "brenoprata10/nvim-highlight-colors",
    opts = {}, -- empty, but apparently required to initialize
  },

  -- extra colorschemes
  { "Shatur/neovim-ayu" },
  -- { "rebelot/kanagawa.nvim" },

  -- set colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu-dark",
      -- colorscheme = "catppuccin",
      -- colorscheme = "kanagawa",
    },
  },

  -- Rounded borders around windows where possible
  {
    "LazyVim/LazyVim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
}
