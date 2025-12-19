vim.pack.add({ "https://github.com/zuqini/zpack.nvim" })

require("config.options")
require("config.keymaps")
require("zpack").setup({})
require("config.lsp")

