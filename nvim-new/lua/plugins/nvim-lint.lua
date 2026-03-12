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
}
