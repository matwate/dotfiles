return {
  {
    "mfussenegger/nvim-lint",
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "ruff" },
      }

      local augroup = vim.api.nvim_create_augroup("LintAutogroup", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- use defaults; configure via keymaps below
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
