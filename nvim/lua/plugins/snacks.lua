return -- lazy.nvim
{
  "folke/snacks.nvim",
  keys = {
    { "<C-n>", function() Snacks.explorer() end, desc = "Open Explorer" },
  },
  ---@type snacks.Config
  opts = {
    dim = {},
    explorer = {
      -- your explorer configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    picker = {
      sources = {
        explorer = {
          -- your explorer picker configuration comes here
          -- or leave it empty to use the default settings
        }
      }
    }
  }
}
