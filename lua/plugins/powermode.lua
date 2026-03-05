---
-- CREATE HERE

return {
  "axsaucedo/neovim-power-mode",
  event = "InsertEnter",
  opts = {
    auto_enable = true,
    colors = {
      -- Format: { "gui_fg", "gui_bg", cterm_fg, cterm_bg }
      color_1 = { "#7CFF01", "#110000", 118, 52 }, -- Stamina Wheel Green
      color_2 = { "#00B0FF", "#110000", 39, 52 }, -- Champion's Tunic Blue
      color_3 = { "#FF6E00", "#110000", 202, 52 }, -- Sheikah Slate Orange
      color_4 = { "#E6004C", "#110000", 161, 52 }, -- Calamity Malice Magenta
      color_5 = { "#FFD700", "#110000", 220, 52 }, -- Triforce / Rupee Gold
      color_6 = { "#F0F8FF", "#110000", 255, 52 }, -- Silent Princess White
      color_7 = { "#00FFAA", "#110000", 49, 52 }, -- Luminous Stone Cyan
      color_8 = { "#4A881B", "#110000", 64, 52 }, -- Hyrule Field Grass
    },
    particles = {
      preset = "custom",
      cancel_on_new = false, -- Let the leaves and sparkles linger
      custom = {
        chars = { "🍃", "✨", "✦", "🧚", "💨", "🛡️", "🗡️", "🏹" },
        count = { 2, 4 }, -- Sparse and quiet, not overwhelming
        speed = { 3, 7 }, -- Gentle floating
        lifetime = { 600, 1200 }, -- Slower decay
        gravity = 0.05, -- Low gravity (paraglider updraft physics)
        drag = 0.96, -- Gliding air resistance
        spread = { -3.0, 3.0 }, -- Wide, sweeping wind bursts
        upward_bias = 0.7, -- Strong Revali's Gale updraft effect
      },
    },
    shake = {
      mode = "none", -- Disable shake to maintain readability
    },
  },
}

---- DO NOT EDIT PAST THIS
--return {
--  -- Similar to Rediculous coding plugin
--  {
--    "axsaucedo/neovim-power-mode",
--    event = "VeryLazy",
--    opts = {
--      shake = {
--        mode = "scroll", -- "scroll" for viewport jitter, "none" to disable
--      },
--      particles = {
--        preset = "stars", -- options: "explosion", "fountain", "stars", "emoji"
--      },
--    },
--  },
--
--  -- Keystroke sounds
--  {
--    "jackplus-xyz/player-one.nvim",
--    event = "InsertEnter",
--    opts = {
--      -- Default 8-bit sound themes: "chiptune", "crystal", "synth"
--      theme = "chiptune",
--    },
--  },
--
--  -- Markdown Rendering
--  {
--    "MeanderingProgrammer/render-markdown.nvim",
--    opts = {
--      file_types = { "markdown" },
--    },
--    ft = { "markdown" },
--  },
--}
