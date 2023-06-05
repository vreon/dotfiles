-- Basic configuration for language support.

return {
  -- Additional LSPs etc.
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      ---@diagnostic disable-next-line: missing-parameter
      vim.list_extend(opts.ensure_installed, {
        "bash-language-server",
        "black",
        "ruff-lsp",
        "shellcheck",
        "terraform-ls",
      })
    end,
  },

  -- Additional Treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      ---@diagnostic disable-next-line: missing-parameter
      vim.list_extend(opts.ensure_installed, {
        "graphql",
        "hcl",
      })
    end,
  },

  -- Formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.black,
        },
      }
    end,
  },
}
