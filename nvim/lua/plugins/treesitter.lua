return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local configs = require("nvim-treesitter")
		configs.setup({
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = "maintained",
			auto_install = false,
		})
	end,
}
