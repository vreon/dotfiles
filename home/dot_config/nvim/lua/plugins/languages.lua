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
        "prettier",
        "shellcheck",
        "svelte-language-server",
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
        "css",
        "graphql",
        "hcl",
        "svelte",
      })
    end,
  },
}
