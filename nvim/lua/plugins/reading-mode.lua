return {
  -- Aerial: Code Outline (Sidebar)
  {
    "stevearc/aerial.nvim",
    opts = {
      -- Basic setup first
      layout = {
        max_width = { 40, 0.3 },
        min_width = 20,
        default_direction = "right",
        placement = "edge",
      },
      show_guides = true,
      -- Try both backends
      backends = { "lsp", "treesitter", "markdown", "man" },
      -- Show all symbol types
      filter_kind = false,
      -- Highlight settings
      highlight_closest = true,
      highlight_on_hover = true,
      highlight_on_jump = 300,
      -- Make sure it's visible
      close_automatic_events = {},
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    keys = {
      { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Toggle Code Outline" },
      { "<leader>ao", "<cmd>AerialOpen<cr>", desc = "Open Code Outline" },
      { "<leader>ac", "<cmd>AerialClose<cr>", desc = "Close Code Outline" },
      { "<leader>ai", "<cmd>AerialInfo<cr>", desc = "Aerial Info (Debug)" },
    },
  },

  -- Simple layout toggle
  {
    "stevearc/aerial.nvim",
    config = function()
      local function toggle_layout()
        -- First, let's just try to open Aerial and see what happens
        local aerial = require("aerial")
        
        -- Check if Aerial can see any symbols
        local symbols = aerial.get_symbols()
        if symbols and #symbols > 0 then
          vim.notify("Found " .. #symbols .. " symbols", vim.log.levels.INFO)
        else
          vim.notify("No symbols found. Check :AerialInfo for details", vim.log.levels.WARN)
        end
        
        -- Toggle Aerial
        aerial.toggle({ direction = "right" })
        
        -- Toggle Snacks explorer
        Snacks.explorer({
          win = {
            position = "left",
            width = 35,
          }
        })
      end
      
      vim.keymap.set("n", "<leader>rm", toggle_layout, { 
        desc = "Toggle Explorer + Outline",
        silent = true 
      })
    end,
  },
}
