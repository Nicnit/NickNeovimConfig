-- ============================================================================
-- PLUGIN CONFIGURATIONS
-- ============================================================================

return {
  -- Environment: Falling Autumn Leaves
  {
    "folke/drop.nvim",
    event = "VimEnter",
    config = function()
      require("drop").setup({
        theme = "leaves",
        max = 7,
        interval = 750,
        screensaver = false,
        filetypes = { -- Added a bunch of file types for universal coverage. originally just markdown, dashboard, alpha, text.
          "markdown",
          "text",
          "rst",
          "org",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "html",
          "css",
          "scss",
          "vue",
          "svelte",
          "c",
          "cpp",
          "go",
          "rust",
          "zig",
          "python",
          "ruby",
          "php",
          "lua",
          "vim",
          "json",
          "yaml",
          "toml",
          "xml",
          "sql",
          "bash",
          "sh",
          "dockerfile",
          "makefile",
        },
      })
    end,
  },

  -- Typing Feedback: Breath of the Wild Power Mode (rightburst)
  {
    "axsaucedo/neovim-power-mode",
    event = "InsertEnter",
    opts = {
      auto_enable = true,
      combo = { enabled = false },
      colors = {
        color_1 = { "#7CFF01", "#110000", 118, 52 }, -- Stamina Green
        color_2 = { "#00B0FF", "#110000", 39, 52 }, -- Champion Blue
        color_3 = { "#FF6E00", "#110000", 202, 52 }, -- Sheikah Orange
        color_4 = { "#F0F8FF", "#110000", 255, 52 }, -- Silent Princess White
      },
      particles = {
        preset = "rightburst",
        cancel_on_new = false,
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
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "markdown" },
        providers = {
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
          },
        },
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
      exclude = { "terminal", "dashboard", "alpha", "starter", "notify" },
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
}
