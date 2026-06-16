return {
  {
    "zaldih/themery.nvim",
    lazy = false,
    opts = {
      themes = {
        -- Here you list the themes you want to show up in the menu
        --       "desert",
        "tokyonight",
        "gruvbox",
        "everforest",
        "default",
      },
      globalAfter = [[
        -- main editor background
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

        -- neo-tree file explorer
        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none" })

        -- gutter and line numbers
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
        vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

        -- cursor line + LSP highlights
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
        vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "none" })
        vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "none" })
        vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "none" })
      ]],
      livePreview = true, -- See the theme change as you scroll
    },
  },
  -- We also need to make sure the plugins for those themes are installed
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "sainnhe/everforest",
    opts = {
      background = "hard",
      transparent_background_level = 2,
      italics = true,
      ui_contrast = "low",
    },
  },
}
