return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      ghost_text = { enabled = false },
      -- Disable tab completion suggestions for markdown and normal writing
      menu = {
        auto_show = function(ctx)
          if vim.bo.filetype == "markdown" then
            return false
          end
          return true
        end,
      },
    },
    keymap = {
      preset = "super-tab",
      ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
      ["<CR>"] = { "fallback" },
    },
  },
}
