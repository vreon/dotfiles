-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Old habits: <leader>n to clear search (etc.)
-- Adapted from LazyVim defaults linked above.
vim.keymap.set(
  "n",
  "<leader>n",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

vim.keymap.set("n", "<leader>ux", "<Cmd>HighlightColorsToggle<CR>", { desc = "Toggle color highlighting" })

-- From https://github.com/willnorris/dotfiles/blob/main/config/nvim/lua/config/keymaps.lua
-- Restore 'gw' to default behavior. First, remove the 'gw' keymap set in LazyVim:
vim.keymap.del({ "n", "x" }, "gw")
-- Then, reset formatexpr if null-ls is not providing any formatting generators.
-- See: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
require("lazyvim.util").on_attach(function(client, buf)
  if client.name == "null-ls" then
    if not require("null-ls.generators").can_run(vim.bo[buf].filetype, require("null-ls.methods").lsp.FORMATTING) then
      vim.bo[buf].formatexpr = nil
    end
  end
end)
