-- Handle diagnostics and error showing

return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
      virtual_lines = false,
    })
  end,
}
