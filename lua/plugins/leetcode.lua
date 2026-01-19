return {
  {
    "kawre/leetcode.nvim",
    -- This build command is the 'html' requirement you mentioned
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Ensuring the picker requirement is met
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      arg = "leetcode.nvim",
      lang = "cpp", -- As a GT student, C++ is your best bet here
      -- This ensures it uses telescope, even if LazyVim is using snacks elsewhere
      picker = { provider = "telescope" },
    },
  },
}
