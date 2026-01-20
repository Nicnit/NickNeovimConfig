-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--- Webdev Lazyrc setup method using :SetupWeb or similar
-- ~/.config/nvim/lua/config/keymaps.lua (or equivalent)

--- :SetupWeb for webdev .lazy.lua (see with ls -a)

local root_markers = {
  ".lazy.lua",
  ".git",
  ".hg",
  ".svn",
  "ProjectSettings",
  "package.json",
  "pyproject.toml",
  "CMakeLists.txt",
  "compile_commands.json",
  "Makefile",
}

local function start_path()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname ~= "" then
    return bufname
  end

  local arg0 = vim.fn.argv(0)
  if arg0 ~= "" then
    return arg0
  end

  return vim.fn.getcwd()
end

local function project_root()
  if vim.fs and vim.fs.root then
    return vim.fs.root(start_path(), root_markers)
  end
end

local function write_profile(profile_name, content)
  local root = project_root() or vim.fn.getcwd()
  local path = root .. "/.lazy.lua"

  if vim.fn.filereadable(path) == 1 then
    local choice = vim.fn.confirm(".lazy.lua already exists. Overwrite?", "&Yes\n&No", 2)
    if choice ~= 1 then
      vim.notify("Canceled. .lazy.lua already exists.", vim.log.levels.INFO, {
        title = "Project Setup",
      })
      return
    end
  end

  local f = io.open(path, "w")
  if f then
    f:write(content)
    f:close()
    local trust = io.open(root .. "/.lazy.lua.trust", "w")
    if trust then
      trust:write("trusted\n")
      trust:close()
    end
    vim.notify("Created .lazy.lua (" .. profile_name .. "). Restart Neovim to activate it.", vim.log.levels.INFO, {
      title = "Project Setup",
    })
  else
    vim.notify("Failed to create .lazy.lua. Check folder permissions.", vim.log.levels.ERROR)
  end
end

local web_profile = [[
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

local unity_profile = [[
return {
  { import = "lazyvim.plugins.extras.lang.omnisharp" },
}
]]

local cpp_profile = [[
return {
  { import = "lazyvim.plugins.extras.lang.clangd" },
}
]]

local low_level_profile = [[
return {
  { import = "lazyvim.plugins.extras.lang.clangd" },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap" },
      }
      local cfg = {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      }
      dap.configurations.c = { cfg }
      dap.configurations.cpp = { cfg }
    end,
  },
}
]]

local function setup_web_project()
  write_profile("Web", web_profile)
end

local function setup_unity_project()
  write_profile("Unity", unity_profile)
end

local function setup_cpp_project()
  write_profile("C++", cpp_profile)
end

local function setup_low_level_project()
  write_profile("Low-Level", low_level_profile)
end

vim.api.nvim_create_user_command("SetupWeb", setup_web_project, {})
vim.api.nvim_create_user_command("SetupUnity", setup_unity_project, {})
vim.api.nvim_create_user_command("SetupCpp", setup_cpp_project, {})
vim.api.nvim_create_user_command("SetupLowLevel", setup_low_level_project, {})
vim.keymap.set("n", "<leader>pw", setup_web_project, { desc = "Initialize Web Dev .lazy.lua" })
vim.keymap.set("n", "<leader>pu", setup_unity_project, { desc = "Initialize Unity .lazy.lua" })
vim.keymap.set("n", "<leader>pc", setup_cpp_project, { desc = "Initialize C++ .lazy.lua" })
vim.keymap.set("n", "<leader>pl", setup_low_level_project, { desc = "Initialize Low-Level .lazy.lua" })
