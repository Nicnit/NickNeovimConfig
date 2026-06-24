return {
  {
    "nvim-focus/focus.nvim",
    version = "*", -- stable version
    config = function()
      require("focus").setup({
        -- options
      })
    end,
  },
}
