return {
  -- Disable animated popups.
  { "rcarriga/nvim-notify",            enabled = false },

  -- Disable fancy jumping, which isn't compatible with my muscle memory.
  { "folke/flash.nvim",                enabled = false },

  -- Disable automatic brace/bracket/paren insertion, which gets in my way more
  -- often than it helps.
  { "echasnovski/mini.pairs",          enabled = false },

  -- Disable nvim-treesitter powered indentation, it's not quite there yet, esp. for YAML
  { "nvim-treesitter/nvim-treesitter", opts = { indent = { enable = false } } },

  -- The default (in LazyVim) behavior of nvim-cmp is to complete text when you
  -- press <CR>. That's absolute madness. Here, we configure things to use <Tab>
  -- instead, with <C-j> / <C-k> to select items.
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<CR>"] = cmp.config.disable,
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
