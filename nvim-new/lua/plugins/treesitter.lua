return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local configs = require("nvim-treesitter")

		require("nvim-treesitter").setup({
			auto_install = true,
		})
		configs.install({ "go", "lua", "zig", "python", "cuda", "c", "cpp", "rust", "java", "typst", "gleam" })
	end,
}
