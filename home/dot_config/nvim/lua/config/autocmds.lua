-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local api = vim.api

-- Remove the default autocmd that sets the cursor to its last
-- location when opening a buffer. This is cool, but it seems to
-- also affect .git/COMMIT_EDITMSG
api.nvim_del_augroup_by_name("lazyvim_last_loc")

-- Disable automatic comment leader insertion when inserting new lines, and
-- ensure that wrapping is applied to text and comments. Set formatoptions late
-- to ensure that it doesn't get clobbered by an ftplugin.
api.nvim_create_autocmd("FileType", {
  command = [[set fo-=ro fo+=t]]
})
