-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    local arg_count = vim.fn.argc()
    if arg_count == 1 and vim.fn.isdirectory(arg) == 1 then
      require("neo-tree.command").execute({ dir = arg, reveal = true })
    elseif arg_count == 0 or (arg_count == 1 and vim.fn.isdirectory(arg) == 0) then
      -- vim.cmd("Twilight") -- Twilight auto enable
    end
  end,
  desc = "Open neo-tree for directory or enable Twilight for files",
})
