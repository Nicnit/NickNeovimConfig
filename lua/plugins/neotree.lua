return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  -- VERY IMPORTANT: Disable lazy loading so it can hijack netrw on startup
  lazy = false,
  keys = {
    { "<leader>e", "<leader>fe", desc = "Explorer NeoTree", remap = true },
  },
  opts = {
    filesystem = {
      -- This is the specific setting that replaces netrw
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = true,
    },
  },
}
