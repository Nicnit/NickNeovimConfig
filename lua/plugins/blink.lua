return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      ghost_text = { enabled = false },
    },
    keymap = {
      preset = "super-tab",
      ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
      ["<CR>"] = { "fallback" },
    },
  },
}

