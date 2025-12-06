return {
  {
    "github/copilot.vim",
  },
  -- tailwind-tools.lua
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    event = "VeryLazy",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
    opts = {}                        -- your configuration
  }
}
