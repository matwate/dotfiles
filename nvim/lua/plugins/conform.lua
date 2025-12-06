return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        go = { 'gofumpt', 'goimports-reviser', 'golines' },
        python = { 'black' },
        cpp = { 'clang-format' },
        c = { 'clang-format' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        json = { 'prettierd' },
        vue = { 'prettierd' },
        templ = { 'gofumpt', 'templ', 'injected' },
        html = { 'prettierd' },
        css = { 'prettierd' },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = 'never',
      }
    })
  end,
}
