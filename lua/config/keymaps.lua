-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--- Webdev Lazyrc setup method using :SetupWeb or similar
-- ~/.config/nvim/lua/config/keymaps.lua (or equivalent)

--- :SetupWeb for webdev .lazy.lua (see with ls -a)

local function setup_web_project()
  local path = vim.fn.getcwd() .. "/.lazy.lua"

  local content = [[
return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.json" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {},
      },
    },
  },
}
]]

  local f = io.open(path, "w")
  if f then
    f:write(content)
    f:close()
    -- Use a clean notification without trying to force-load lazy
    vim.notify("Created .lazy.lua! Restart Neovim to activate the new project spec.", vim.log.levels.INFO, {
      title = "Project Setup",
    })
  else
    vim.notify("Failed to create .lazy.lua. Check folder permissions.", vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_user_command("SetupWeb", setup_web_project, {})
vim.keymap.set("n", "<leader>pw", setup_web_project, { desc = "Initialize Web Dev .lazy.lua" })
