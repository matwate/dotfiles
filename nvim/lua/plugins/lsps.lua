return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ui = { border = "rounded" },
    },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- LSP servers
        "lua-language-server",
        "clangd",
        "gopls",
        "pyright",
        "html-lsp",
        "tailwindcss-language-server",
        "templ",
        "zls",
        "vtsls",
        "vue-language-server",
        "tinymist",
        -- Formatters / Linters
        "black",
        "ruff",
        "prettierd",
        "clang-format",
        "gofumpt",
        "goimports-reviser",
        "golines",
        "shellcheck",
      },
      run_on_start = true,
    },
  },
  {
  "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Defaults for all servers
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- Diagnostics UX
      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        signs = true,
      })

      -- Buffer-local keymaps and inlay hints on attach
      local group = vim.api.nvim_create_augroup('my.lsp', { clear = true })
      vim.api.nvim_create_autocmd('LspAttach', {
        group = group,
        callback = function(args)
          local bufnr = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          map('n', 'K', vim.lsp.buf.hover, 'Hover')
          map('n', 'gd', vim.lsp.buf.definition, 'Goto Definition')
          map('n', 'gD', vim.lsp.buf.declaration, 'Goto Declaration')
          map('n', 'gi', vim.lsp.buf.implementation, 'Goto Implementation')
          map('n', 'gr', vim.lsp.buf.references, 'References')
          map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename')
          map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
          map('n', 'gl', vim.diagnostic.open_float, 'Line Diagnostics')
          map('n', '[d', vim.diagnostic.goto_prev, 'Prev Diagnostic')
          map('n', ']d', vim.diagnostic.goto_next, 'Next Diagnostic')

          if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
            pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
          end
        end,
      })

      -- Server-specific configuration using the new API
      vim.lsp.config('clangd', {
        cmd = { 'clangd', '--background-index', '--clang-tidy', '--completion-style=detailed', '--header-insertion=never' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt', '.git' },
      })

      vim.lsp.config('gopls', {
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_markers = { 'go.mod', '.git' },
        settings = {
          gopls = {
            gofumpt = true,
            staticcheck = true,
            analyses = {
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            codelenses = {
              test = true,
              tidy = true,
              run_govulncheck = true,
              upgrade_dependency = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            completion = { callSnippet = 'Replace' },
            diagnostics = { globals = { 'vim' } },
          },
        },
      })

      vim.lsp.config('tailwindcss', {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = { "tw`([^`]*)", 'tw%("([^"]*)', 'tw=%"([^"]*)' },
            },
          },
        },
      })


      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            completion = { callSnippet = 'Replace' },
            diagnostics = { globals = { 'vim', 'lspconfig' } },
          },
        },
      })

      vim.lsp.config('qmlls', {
        filetypes = { 'qml', 'qtquick' },
      })


      -- Enable all desired servers (others use defaults from lspconfig repository)
      vim.lsp.enable({
        'lua_ls',
        'clangd',
        'gopls',
        'pyright',
        'html',
        'tailwindcss',
        'templ',
        'zls',
        'vtsls',
        "tinymist",
      })
    end,
  },
}
