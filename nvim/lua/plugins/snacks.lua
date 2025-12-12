return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    { "<C-n>", function() Snacks.explorer() end, desc = "Open Explorer" },
    { "<C-p>", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Live Grep" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Find Help" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
    { "<leader>gc", function() Snacks.picker.git_commits() end, desc = "Git Commits" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
  },
  opts = {
    bigfile = { enabled = true },
    notifier = { 
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    picker = {
      enabled = true,
      sources = {
        files = {
          hidden = false,
        },
        grep = {
          hidden = false,
        },
      },
    },
    explorer = {
      enabled = true,
    },
    statusline = {
      enabled = true,
    },
  },
}
