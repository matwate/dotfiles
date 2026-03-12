vim.pack.add({ "https://github.com/zuqini/zpack.nvim" })

require("config.options")
require("config.keymaps")
require("config.lsp")

require("zpack").setup({})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "lua", "zig", "python", "rust", "java", "gleam", "typst" },
	callback = function(args)
		-- This is the core Neovim command that actually turns on the colors
		vim.treesitter.start(args.buf)
	end,
})

-- Add your local folder to Neovim's Runtime Path (RTP)
-- Adjust the path if your folder is named differently
local camellia_path = vim.fn.stdpath("config") .. "/lua/camellia-hope.nvim"
vim.opt.rtp:prepend(camellia_path)
