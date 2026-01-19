return {
  {
    "zaldih/themery.nvim",
    lazy = false,
    opts = {
      themes = {
        -- Here you list the themes you want to show up in the menu
        "desert",
        "tokyonight",
        "gruvbox",
        "everforest",
        "default",
      },
      livePreview = true, -- See the theme change as you scroll
    },
  },
  -- We also need to make sure the plugins for those themes are installed
  { "ellisonleao/gruvbox.nvim" },
  { "sainnhe/everforest" },
}
