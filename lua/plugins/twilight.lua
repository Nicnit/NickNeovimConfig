return {
  "folke/twilight.nvim",
  enabled = false,
  opts = {
    dimming = {
      alpha = 1, -- Default is 0.25. 0.40 is softer and easier on the eyes for prose.
      color = { "Normal", "#ffffff" },
      term_bg = "#000000",
      inactive = false, -- Fully dims other Neovim splits/windows to maximize focus.
    },
    context = 15, -- Keeps 15 lines above and below the cursor visible.
    treesitter = true,
    expand = {
      -- Markdown-specific TreeSitter nodes to keep fully illuminated together
      "paragraph",
      "section", -- Keeps the entire block under a heading lit
      "list", -- Keeps the whole list lit, rather than just one bullet
      "block_quote",
      "fenced_code_block",
    },
  },
}
