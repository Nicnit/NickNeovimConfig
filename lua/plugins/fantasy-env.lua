-- ============================================================================
-- 1. GLOBAL AUTOCOMMANDS
-- ============================================================================
-- Automatically open Neo-tree if Neovim is launched with a directory argument.
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    if vim.fn.argc() == 1 and type(arg) == "string" and vim.fn.isdirectory(arg) == 1 then
      require("neo-tree.command").execute({ dir = arg, reveal = true })
    end
  end,
})

-- ============================================================================
-- 2. PLUGIN CONFIGURATIONS
-- ============================================================================
return {
  -- Core Theme: Everforest
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "hard",
        transparent_background_level = 1,
        italics = true,
        ui_contrast = "low",
      })
      -- Note: Remove this vim.cmd line if you are using Themery to manage themes
      vim.cmd([[colorscheme everforest]])
    end,
  },

  -- Environment: Falling Autumn Leaves
  {
    "folke/drop.nvim",
    event = "VimEnter",
    config = function()
      require("drop").setup({
        theme = "leaves",
        max = 35,
        interval = 150,
        screensaver = false,
      })
    end,
  },

  -- Typing Feedback: Breath of the Wild Power Mode
  {
    "axsaucedo/neovim-power-mode",
    event = "InsertEnter",
    opts = {
      auto_enable = true,
      colors = {
        color_1 = { "#7CFF01", "#110000", 118, 52 },
        color_2 = { "#00B0FF", "#110000", 39, 52 },
        color_3 = { "#FF6E00", "#110000", 202, 52 },
        color_4 = { "#F0F8FF", "#110000", 255, 52 },
      },
      particles = {
        preset = "custom",
        cancel_on_new = false,
        custom = {
          -- Replaced complex emojis with safe, magical Unicode characters
          chars = { "✧", "✦", "⋆", "✶", "°", "·" },
          count = { 3, 5 },
          speed = { 5, 12 }, -- Increased base velocity
          lifetime = { 600, 1200 },
          gravity = 0.05,
          drag = 0.96,
          spread = { -12.0, 12.0 }, -- Widened horizontal explosion
          upward_bias = 1.8, -- Stronger upward burst on keystroke
        },
      },
      shake = { mode = "none" },
    },
  },

  -- Autocompletion Control: Silence menus while writing prose
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = { enabled = false },
        menu = {
          auto_show = function(ctx)
            return vim.bo.filetype ~= "markdown"
          end,
        },
      },
      keymap = {
        preset = "super-tab",
        ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
        ["<CR>"] = { "fallback" },
      },
    },
  },

  -- Focus: Twilight (Adjusted for Prose readability)
  {
    "folke/twilight.nvim",
    opts = {
      dimming = {
        alpha = 0.40,
        inactive = true,
      },
      context = 15,
      treesitter = true,
      expand = { "paragraph", "section", "list", "block_quote" },
    },
  },

  -- Visual Polish: Render Markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown" },
    },
    ft = { "markdown" },
  },

  -- Companion: Pixel Art Pets
  {
    "giusgad/pets.nvim",
    dependencies = {
      "edluffy/hologram.nvim",
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy", -- Forces the plugin to boot after the UI loads
    opts = {
      row = 1,
      default_pet = "dog",
      default_style = "brown",
      random = true,
    },
  },
}
