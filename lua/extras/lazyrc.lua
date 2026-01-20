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

local function local_spec_allowed(root)
  local local_spec_path = root .. "/.lazy.lua"
  if vim.fn.filereadable(local_spec_path) ~= 1 then
    return false
  end

  local trust_path = root .. "/.lazy.lua.trust"
  if vim.fn.filereadable(trust_path) == 1 then
    return true
  end

  local choice = vim.fn.confirm("Load .lazy.lua for this project?", "&Yes\n&No", 2)
  if choice == 1 then
    local f = io.open(trust_path, "w")
    if f then
      f:write("trusted\n")
      f:close()
    end
    return true
  end

  return false
end

local root = project_root() or vim.fn.getcwd()

return {
  {
    "folke/lazy.nvim",
    opts = {
      local_spec = local_spec_allowed(root),
    },
  },
}
