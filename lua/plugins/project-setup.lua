-- Moved from config folder
-- Suggested location: lua/plugins/project-setup.lua
-- (It is a bit heavy to keep inside config/keymaps.lua)

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
  "Cargo.toml",
  "go.mod",
}

local function get_project_root()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    path = vim.fn.getcwd()
  end
  -- vim.fs.root is available in Nvim 0.10+
  if vim.fs and vim.fs.root then
    return vim.fs.root(path, root_markers) or vim.fn.getcwd()
  end
  return vim.fn.getcwd()
end

local function write_profile(profile_name, content)
  local root = get_project_root()
  local path = root .. "/.lazy.lua"
  local trust_path = root .. "/.lazy.lua.trust"

  if vim.fn.filereadable(path) == 1 then
    if vim.fn.confirm("Overwrite existing .lazy.lua?", "&Yes\n&No", 2) ~= 1 then
      return
    end
  end

  local f = io.open(path, "w")
  if f then
    f:write(content)
    f:close()

    -- Auto-trust the file
    local t = io.open(trust_path, "w")
    if t then
      t:write("trusted\n")
      t:close()
    end

    vim.notify("Setup " .. profile_name .. " profile. Restart Neovim to apply.", vim.log.levels.INFO)
  else
    vim.notify("Failed to write config. Check permissions.", vim.log.levels.ERROR)
  end
end

-- ==========================================
-- PROFILES
-- ==========================================

local profiles = {}

profiles.Web = [[
return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.json" },
  {
    "neovim/nvim-lspconfig",
    opts = { servers = { vtsls = {} } },
  },
}
]]

profiles.Unity = [[
return {
  { import = "lazyvim.plugins.extras.lang.dotnet" },
  -- Correctly register Unity filetypes
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, { "c_sharp", "json", "xml" })
      
      -- Register filetypes here or in a separate init block
      vim.filetype.add({
        extension = {
          asmdef = "json", asmref = "json", 
          unity = "yaml", prefab = "yaml", asset = "yaml", meta = "yaml",
          shader = "hlsl", cginc = "hlsl",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          enable_editorconfig_support = true,
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
        },
      },
    },
  },
}
]]

profiles.Cpp = [[
return { { import = "lazyvim.plugins.extras.lang.clangd" } }
]]

profiles.Rust = [[
return { { import = "lazyvim.plugins.extras.lang.rust" } }
]]

profiles.Go = [[
return { { import = "lazyvim.plugins.extras.lang.go" } }
]]

profiles.LowLevel = [[
return {
  { import = "lazyvim.plugins.extras.lang.clangd" },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function(_, opts)
      local dap = require("dap")
      
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap" },
      }
      
      local gdb_config = {
        name = "Launch (GDB)",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      }

      dap.configurations.c = dap.configurations.c or {}
      table.insert(dap.configurations.c, gdb_config)
      
      dap.configurations.cpp = dap.configurations.cpp or {}
      table.insert(dap.configurations.cpp, gdb_config)
    end,
  },
}
]]

profiles.Obsidian = [[
return {
  -- 1. Core Languages
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },

  -- 2. LSP Configuration (The "Brain")
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Configure the TypeScript server (vtsls) to be smarter
        vtsls = {
          -- This ensures it uses the Obsidian types from your node_modules
          -- rather than the generic VSCode ones.
          autoUseWorkspaceTsdk = true,
          settings = {
            typescript = {
              suggest = {
                completeFunctionCalls = true,
                includeCompletionsForModuleExports = true,
              },
            },
          },
        },
        -- Keep the schema fix for manifest.json
        jsonls = {
          settings = {
            json = {
              schemas = {
                {
                  fileMatch = { "manifest.json" },
                  url = "http://json-schema.org/draft-07/schema#",
                },
              },
            },
          },
        },
      },
    },
  },
}
]]

-- ==========================================
-- COMMANDS
-- ==========================================

-- Registers: :SetupWeb, :SetupUnity, :SetupCpp, etc.
for name, content in pairs(profiles) do
  vim.api.nvim_create_user_command("Setup" .. name, function()
    write_profile(name, content)
  end, {})
end

return {} -- Return empty table if this file is loaded as a plugin spec
